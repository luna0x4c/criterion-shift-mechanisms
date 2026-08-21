## NOTES
- this (`index.html` on pavlovia) should be whatever the most up to date version is for any exp that has been running. this is because I couldn't keep up with making x3 of all of the minor adjustments in the webstorm projects copies (`-local` & `-pav`) lol. if we need this as a template to work on future projects, work backwards from here to create local copies (remove pavlovia plug ins & connections, etc)
- occasionally there might be a separate copy version of this just for pavlovia upload purposes, because pavlovia study link shows directly what the "real" study name is. use the testing ("real") version for updates/edits, not the masked one

- always document updates in README locally & to gitlab for every major update!


#### to do:

- check data file after piloting!!


- push `index.html` & `README.md` to gitlab (both false feed 02 & memory study 02) 1/26



#### updates log
- updated on: 2022-01-27
- the automatic redirect to Qualtrics breaks pavlovia connection & data will be lost... doing them separately for now


- updated on: 2022-01-26
- updated payment scheme to var `study_reward` thru/o proc
- changed study/test list length to 160 per block 
- got 160*6 = 960 randomly generated stim from `good_stim`
- updated `false_feed_02` and `memory_study_02`

- updated on: 2022-01-23
- given up on subID number feedback... js syntax is annoying
- push this version to gitlab (WITH all console logs)
- create copy version under masked study name
- muted all console logs in copy version & push to pavlovia

- updated on: 2022-01-21
- unmuted all procs & push to pav for self/others (informal) piloting 
- minor fixes & style edits for demographics & attitude survey
- changed html exp name 
- removed total amt earned final adta tagger bc it doesn't work that way lol. see code comments
- console logs preserved for false_feedv2 version of html - this is for testing purposes
- added subID variable (extracted from 'survey-text' reponse) to ALL trials
- created subID <> ID number list in R, including "XXXX/xxxx" <> 999 for testing purpose >>> this file is in archive folder of webstorm false feed 02 folder

- updated on: 2022-01-20
- added 'total amount earned FINAL' variable tagger to ALL trials (for easy access & verification)
- added 'test in task' info for all tests (test 1-2 in each task); this data tagger is the same as the VARIABLE 'test in task' but they are not connected. for independent checking purposes
- not in main proc: updated qualtrics survey to have all Q's on one page (instead of 2)

- updated on: 2022-01-19
- added a media preload plug in to avoid significant loading delay issues
- updated "too slow! continue?" button/keyresp for too slow feedback 

- updated on: 2022-01-18 23:10PM  
- `index.html` corresponding to Webstorm project: false_feed02_v1 >> `false_feed02_va-pav.html`, which is the pavlovia version of `false_feed02_v1-local.html`; the only difference is that pav has pavlovia plug ins/connections loaded whereas the local version is more convenient for local testing   
- currently has unncessary procs (consent form, demo survey, pre-study survey etc) muted. need to unmute for deployment  
- currently has lots of console logs enabled for testing/checking/validation purposes. need to remove for deployment  




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
