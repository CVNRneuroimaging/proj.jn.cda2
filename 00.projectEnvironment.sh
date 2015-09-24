#!/bin/bash

# 00.projectEnvironment.sh
#
# setup environment for subsequent scripts

export projDir="/data/panolocal/processedOnPano-nocera"
export scriptDir="~stowler-local/src.mywork.gitRepos/proj.jn.cda2"

###########################################################
# "typical" sessions include: 
#   1 anat
#   1 rest
#   6 fmritaskCMG

# ...which means that the following are atypical sessions:
#
# cda004pst - missing rest (participant's decision)
# cda009pre - missing anat and rest in acqfiles-nifti and derivedData (TBD: resolve)
# cda106pre - missing anat in acqfiles-nifti and derivedData (TBD: resolve)
# cda011pre and cda011pst - potential pre/post confusion needs to be re-confirmed
# cda011pst - acquired three runs instead of six (eprime issues)
#export sessionsAtypical="cda004pst cda009pre cda011pre cda011pst cda106pre"
#
# ...cda006 is also atypical in naming only: all of the other cda0XX sessionIDs
# are exercise group only, but cda006 is in the control (balance) group


###########################################################
# lists of "typical" sessions, each of which includes:
#     1 anat
#     1 rest
#     6 fmri taskCMG

# exercise participants are cda0XX, except for cda006 who is in the control group:
export sessionsTypicalExercisePre="cda001pre cda002pre cda003pre cda004pre cda005pre cda007pre cda008pre cda010pre cda011pre cda012pre cda013pre"
export sessionsTypicalExercisePst="cda001pst cda002pst cda003pst cda005pst cda007pst cda008pst cda010pst"
export sessionsTypicalExercise="${sessionsTypicalExercisePre} ${sessionsTypicalExercisePst}"

# control participants are cda1XX, except for cda006 who is in the control group despite blind number:
export sessionsTypicalControlPre="cda006pre cda100pre cda101pre cda102pre cda103pre cda104pre cda105pre cda107pre cda108pre cda109pre"
export sessionsTypicalControlPst="cda006pst cda100pst cda101pst cda102pst cda103pst cda104pst cda109pst"
export sessionsTypicalControl="${sessionsTypicalControlPre} ${sessionsTypicalControlPst}"

# combine exercise and control ino single list:
export sessionsTypical="${sessionsTypicalExercise} ${sessionsTypicalControl}"


#######################################################################
# Lists of sessions for 2015Nov analysis. Each session must include:
#     1 anat
#     6 fmri taskCMG
#
# Particicipants only included if they have pre- and post-treatment sessions.

# Excercise sessions will include cda004pst, which is only atypical because it
# is missing RSFMRI, which isn't relevant for 2015Nov analysis:
export sessions2015NovExercisePst="${sessionsTypicalExercisePst} cda004pst"
export sessions2015NovExercisePre="`echo ${sessions2015NovExercisePst} | sed 's/pst/pre/g'`"
#echo $sessions2015NovExercisePre
#echo $sessions2015NovExercisePst



#!!!!!!!!!!!!!!!!
# NB: on OS X but not linux, sed doesn't respect the \n below, and needs to be
# replaced with a call to gsed. Echo may also need to be replaced with echo -e
# (TBD).
#!!!!!!!!!!!!!!!!
# convert lists from rows to columns for other use:
#export sessionsTypical_column="`echo ${sessionsTypical} | sed 's/ /\n/g'`"
#echo "$sessionsTypical_column"
