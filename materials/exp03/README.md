## NOTES
- this (`index.html` on pavlovia) should be whatever the most up to date version is for any exp that has been running. this is because I couldn't keep up with making x3 of all of the minor adjustments in the webstorm projects copies (`-local` & `-pav`) lol. if we need this as a template to work on future projects, work backwards from here to create local copies (remove pavlovia plug ins & connections, etc)
- occasionally there might be a separate copy version of this just for pavlovia upload purposes, because pavlovia study link shows directly what the "real" study name is. use the testing ("real") version for updates/edits, not the masked one

- always document updates in README locally & to gitlab for every major update!


#### global to do:

- check data file after piloting!!
- push `index.html` & `README.md` to gitlab 


- TEST RUN BEFORE PILOT DATA COLLECTION


#### updates to do:

- recorded dtd needs to be +1 (should be same as draw)
    - figure out if +1 needed or not
    
- fix resp_type_real & response_confidence not consistently recorded




#### updates log
updated on: 2023-01-19
- removed venmo requirement at beginning (default amazon gift card)

updated on: 2022-11-02
- filled in data.studied in test blocks (same as correct_resp)
- filled in earned_this_trial


updated on: 2022-10-25
- patched in subj info survey columns that I forgot to put in for 03 


updated on: 2022-10-20
- added a practice block (10 trials)
- MAJOR UPDATE: changed prob manipulation old/new from 75/25 to 50/50
- added/edited some survey03 questions


updated on: 2022-10-18
- fixed confidence rating text spacing (looks like pre tag compresses start/end whitespace but not middle; might just need to mess with it to adjust)
- cut mem image stim list from 960 to 640 
- edited max reward amount in consent form
- pushed online version to gitlab, did one test run from the pavlovia pilot button


updated on: 2022-10-17
- updated beads task start/end instructions & prompts (3 trials so far)
- combined beads to mem task; future changes are made in mem (main, `html-local`) file
- edited 03 survey & added link to html file


updated on: 2022-10-16
- made preliminary beads task (3 bins only)


updated on: 2022-10-14
- changed confidence rating from 6 (low/med/high) to 4 (low/high) levels only 
- tried changing trial duration max from 10s to 5s but I think this would be a little too fast especially with confidence ratings
- added confidence tag to data & console log
- removed baseline task, so now there are only two tasks (either prob or fpf)
- changed reward per trial to 1c (so max possible = 160 trials per test block x 2 test block per task x 2 task = 640c)
- changed consent form reward amount from "up to 30" to "up to 10"




updated on: 2022-10-09
- changed key prompt text "press enter" to "press return" for apple keyboard
- changed pav version to local version (i.e. removed pavlovia connection modules at beginning & end) for building & testing
- fixed some inconsistencies between local saved "final" version of the memory-study-02 template with online pav repository (some changes were made online after being uploaded to git); not sure if all changes were found/fixed but always check git repo version if local version is not behaving as it should
- added payment scheme reminder in test instructions; check if they show up okay on screen






#### project details:






*below are copied from bs-test project notes*
#### jspsych-pavlovia integration
- add jquery and jspsych pavlovia plug ins at start of exp but should be AFTER jspsych plugin
- remember to check demo link below to update pavlovia plug in version!! otherwise the project might have trouble running  
- demo: https://gitlab.pavlovia.org/demos/jsPsych_SimpleReactionTime/blob/master/index.html
- copy EXACTLY the code for jquery and pavlovia plug ins; ignore local directory warning msgs
- local git copy folder will be directly under `username_on_computer` folder
- to run correctly on pavlovia, put all exp files in `html` folder and rename the jspsych html file `index.html`


#### steps to push/add files thru git:
- create gitlab & local project folder
- `cd project_folder`
- `git add file_name` to add individual file in cd (in this case should be `html/index.html`); `git add .` for adding all files
- `git commit -m "comments/notes"`
- `git push origin master`
- occasionally will see warning msg that "update rejected because remote contains work that you do not have locally". In that case just do a `pull` first to sync

#### misc pavlovia stuff
- in piloting mode, will download a csv data file at end of exp. not sure if this happens when using a piloting link (not using the "pilot" button on pav dashboard) - need to test this out <<< this might be a "pilot mode" problem - pilot data only gets downloaded to the local device and cannot be downloaded from the dashboard. must be in RUNNING mode to collect data "normally" 


#### important docs:
- jspsych/pavlovia integration: https://pavlovia.org/docs/experiments/create-jsPsych **remove the '' in initializing/wrap code





*git command line instructions: (on new project page, but goes away after committing new files)*
Git global setup  *must*
`git config --global user.name "Luna Li"`
`git config --global user.email "luna.li@psych.ucsb.edu"`

Set up from existing local folder   *must*
`cd existing_local_folder`
`git init`
`git remote add origin git@gitlab.pavlovia.org:luna.li/gitlab_project_name.git`
`git add .`
`git commit -m "Initial commit"`
`git push -u origin master`

Create a new repo   *optional*
`git clone git@gitlab.pavlovia.org:luna.li/gitlab_project_name.git`
`cd gitlab_project_name`
`touch README.md`   *leave out if not needed*
`git add README.md` *leave out if not needed*
`git commit -m "comments/notes"`
`git push -u origin master`

Existing git repo   *optional*
`cd existing_repo`
`git remote rename origin old-origin`
`git remote add origin git@gitlab.pavlovia.org:luna.li/gitlab_project_name.git`
`git push -u origin --all`
`git push -u origin --tags`

Commit minor edits from select files
`git add filename`
`git commit -m "comments"`
`git push -u origin master`
