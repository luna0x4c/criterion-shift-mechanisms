
# ===== clean trials =====

prep_sdt = function(grouped_df) {
  # df needs to be grouped first
  x = grouped_df %>% 
    # use reframe() instead of summarise() to avoid empty/duplicate cell issues
    reframe(
      valid_trials = n(),
      n_hit   = sum(resp_type_real=="hit"),
      n_fa    = sum(resp_type_real=="fa"),
      n_miss  = sum(resp_type_real=="miss"),
      n_cr    = sum(resp_type_real=="cr"),
      n_isold  = sum(correct_resp),
      n_isnew  = valid_trials - n_isold,
      n_sayold = sum(response_translated),
      n_saynew = valid_trials - n_sayold,
      
      meanRT = mean(rt),
      medRT = median(rt),
      
      roll_cond = unique(cond),
      n_rollfpf = case_when(task=="false_feed" & cond=="lib" ~ n_fa,
                            task=="false_feed" & cond=="con" ~ n_miss,
                            TRUE ~ NA),
      n_isfpf   = sum(trial_is_fpf),
      percent_fpf = round(n_isfpf/n_rollfpf,3),
      
      raw_hr  = n_hit/n_isold,
      raw_far = n_fa/n_isnew, 
      transform_hr = ifelse(raw_hr==1|raw_hr==0, 1, 0),
      transform_far = ifelse(raw_far==1|raw_far==0, 1, 0),
      hr = case_when(raw_hr==1 ~ 1 - 1/valid_trials,
                     raw_hr==0 ~ 1/valid_trials,
                     TRUE ~ raw_hr),
      far = case_when(raw_far==1 ~ 1 - 1/valid_trials,
                      raw_far==0 ~ 1/valid_trials,
                      TRUE ~ raw_far)
      
    ) %>% unique() %>%    # otherwise `reframe()` will return full df instead of 1 row per group
    ungroup()
  
  return(x)
  
}

# ===== get ev/uv sdt =====

get_sdt = function(df, s=NULL) { 
  if (is.null(s)) {
    s = 0.8
    message("Using default s = 0.8")
  }
  
  sdt_df = df %>% 
    mutate(    
      # d' & c
      dpr = qnorm(hr) - qnorm(far),
      cri = -(qnorm(hr) + qnorm(far))/2,
      # da & c2
      hit_minus_fa = qnorm(hr) - qnorm(far) * s,
      da = sqrt((2/(1+s^2))) * hit_minus_fa,
      hit_plus_fa = qnorm(hr) + qnorm(far),
      c2 = (-s / (s+1)) * hit_plus_fa,
      # c_far for meta-d calculaation
      c_far = -qnorm(far)
    ) 
  return(sdt_df)
}

# ===== get resptype x conf trial counts for type 2 sdt =====

# prep_sdt_type2 = function(grouped_df) {
#   x = grouped_df %>% 
#     reframe(
#       # "S1" = most to least confidence NEW responses
#       saynew = list(c(sum(resp_type_real=="cr" & conf=="high"),
#                       sum(resp_type_real=="cr" & conf=="low"),
#                       sum(resp_type_real=="fa" & conf=="low"),
#                       sum(resp_type_real=="fa" & conf=="high"))),
#       # "S2" = most to least confidence OLD responses
#       sayold = list(c(sum(resp_type_real=="miss" & conf=="high"),
#                       sum(resp_type_real=="miss" & conf=="low"),
#                       sum(resp_type_real=="hit"  & conf=="low"),
#                       sum(resp_type_real=="hit"  & conf=="high")))
#       # 4 trial counts NESTED in each row
#       
#     ) %>% ungroup()
#   
#   return(x)
# } 

# ===== [!!!] fit MLE for meta-d =====
# adapted from maniscalco & lau 2012 MATLAB code

fit_meta_d_mle = function(nR_S1, nR_S2, da, s, c_far) {
  # nr_s1 = saynew, nr_s2 = sayold [4 counts per group]
  # c_far is c1 here [NOT the c1 in M&C]
  nRatings = length(nR_S1) / 2   # number of conf bins on each side 
  
  # convert da into sd??? units 
  f = s*sqrt(2/(1+s^2))
  d = da/f
  
  negLL = function(par) {
    meta_d = par[1]
    x = par[2:nRatings]
    y = par[(nRatings+1):(2*nRatings-1)]
    
    meta_c1 = c_far * (meta_d / d)
    t2c_S1 = sort(meta_c1 - cumsum(exp(x)))
    t2c_S2 = sort(meta_c1 + cumsum(exp(y)))
    crit = c(t2c_S1, meta_c1, t2c_S2)
    
    pS1_bounds = pnorm(crit)
    pS2_bounds = pnorm((crit - meta_d) * s)
    
    p_S1 = pmax(diff(c(0, pS1_bounds, 1)), 1e-10)
    p_S2 = pmax(diff(c(0, pS2_bounds, 1)), 1e-10)
    
    -sum(nR_S1 * log(p_S1)) - sum(nR_S2 * log(p_S2))
  }
  
  start = c(d, rep(log(0.5), 2*(nRatings-1)))
  opt = optim(par=start, fn=negLL, method = "BFGS")   # UNconstrained
  
  meta_da = opt$par[1] * f
  
  list(meta_d = opt$par[1], 
       meta_da = meta_da,
       mratio = opt$par[1] / d,
       logL = -opt$value, 
       convergence = opt$convergence)
}


get_sdt_type2 = function(df, s = NULL) {
  if (is.null(s)) {
    s = 0.8
    message("Using default s = 0.8")
  }
  
  meta_df = df %>% 
    rowwise() %>% 
    mutate(
      nR_S1 = list(c(cr_high, cr_low, fa_low, fa_high)),
      nR_S2 = list(c(miss_high, miss_low, hit_low, hit_high)),
      # remove da==0
      fit = list(fit_meta_d_mle(nR_S1, nR_S2, da, s, c_far)),
      meta_da = fit$meta_da,
      mratio  = fit$mratio, 
      meta_convergence = fit$convergence   # 0=success!!!
    ) %>% 
    ungroup() %>% 
    select(-fit, -nR_S1, -nR_S2)
  
  return(meta_df)
}


