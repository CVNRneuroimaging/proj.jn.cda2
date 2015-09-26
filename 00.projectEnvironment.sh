#!/bin/bash

# 00.projectEnvironment.sh
#
# setup environment for subsequent scripts

fxnCheckSessions(){
   # Function to check the completeness of a session.
   #
   # Call like: fxnCheckSessions "$sessions2015NovControlPre"
   #
   # Returns size of the session's individual analysis products, or if a
   # particular product is not present (non-zero), it is added to a list of
   # missing products which is printed to stdout at the end of the fxn.


   # These are the suffixes of per-session outputs that should be found in ${projDir}/derivedData/${session}/
   suffixListAnat="manualCOG.txt anat.nii.gz anat_brain.nii.gz anat_brain_mask.nii.gz optiBET"
   suffixListQC="qcReport-FBIRN-rest qcReport-FBIRN-taskCMG"
   suffixListFmri="fmri.rest.run1.nii.gz fmri.taskCMG.run1.nii.gz fmri.taskCMG.run2.nii.gz fmri.taskCMG.run3.nii.gz fmri.taskCMG.run4.nii.gz fmri.taskCMG.run5.nii.gz fmri.taskCMG.run6.nii.gz"
   suffixListMelodicFixNone="fmri.rest.run1.melodicFixNone.ica fmri.taskCMG.run1.melodicFixNone.ica fmri.taskCMG.run2.melodicFixNone.ica fmri.taskCMG.run3.melodicFixNone.ica fmri.taskCMG.run4.melodicFixNone.ica fmri.taskCMG.run5.melodicFixNone.ica fmri.taskCMG.run6.melodicFixNone.ica"
   suffixListMelodicFixRest="fmri.rest.run1.melodicFixStandard20*ica fmri.rest.run1.melodicFixStandard18*ica fmri.rest.run1.melodicFixStandard15*ica fmri.rest.run1.melodicFixStandard10*ica fmri.rest.run1.melodicFixWhII_Standard20*ica fmri.rest.run1.melodicFixWhII_Standard18*ica fmri.rest.run1.melodicFixWhII_Standard15*ica fmri.rest.run1.melodicFixWhII_Standard10*ica " 
   suffixListMelodicFixTaskRun1="fmri.taskCMG.run1.melodicFixStandard20*ica fmri.taskCMG.run1.melodicFixStandard18*ica fmri.taskCMG.run1.melodicFixStandard15*ica fmri.taskCMG.run1.melodicFixStandard10*ica fmri.taskCMG.run1.melodicFixWhII_Standard20*ica fmri.taskCMG.run1.melodicFixWhII_Standard18*ica fmri.taskCMG.run1.melodicFixWhII_Standard15*ica fmri.taskCMG.run1.melodicFixWhII_Standard10*ica"
   suffixListMelodicFixTaskRun2="fmri.taskCMG.run2.melodicFixStandard20*ica fmri.taskCMG.run2.melodicFixStandard18*ica fmri.taskCMG.run2.melodicFixStandard15*ica fmri.taskCMG.run2.melodicFixStandard10*ica fmri.taskCMG.run2.melodicFixWhII_Standard20*ica fmri.taskCMG.run2.melodicFixWhII_Standard18*ica fmri.taskCMG.run2.melodicFixWhII_Standard15*ica fmri.taskCMG.run2.melodicFixWhII_Standard10*ica"
   suffixListMelodicFixTaskRun3="fmri.taskCMG.run3.melodicFixStandard20*ica fmri.taskCMG.run3.melodicFixStandard18*ica fmri.taskCMG.run3.melodicFixStandard15*ica fmri.taskCMG.run3.melodicFixStandard10*ica fmri.taskCMG.run3.melodicFixWhII_Standard20*ica fmri.taskCMG.run3.melodicFixWhII_Standard18*ica fmri.taskCMG.run3.melodicFixWhII_Standard15*ica fmri.taskCMG.run3.melodicFixWhII_Standard10*ica"
   suffixListMelodicFixTaskRun4="fmri.taskCMG.run4.melodicFixStandard20*ica fmri.taskCMG.run4.melodicFixStandard18*ica fmri.taskCMG.run4.melodicFixStandard15*ica fmri.taskCMG.run4.melodicFixStandard10*ica fmri.taskCMG.run4.melodicFixWhII_Standard20*ica fmri.taskCMG.run4.melodicFixWhII_Standard18*ica fmri.taskCMG.run4.melodicFixWhII_Standard15*ica fmri.taskCMG.run4.melodicFixWhII_Standard10*ica"
   suffixListMelodicFixTaskRun5="fmri.taskCMG.run5.melodicFixStandard20*ica fmri.taskCMG.run5.melodicFixStandard18*ica fmri.taskCMG.run5.melodicFixStandard15*ica fmri.taskCMG.run5.melodicFixStandard10*ica fmri.taskCMG.run5.melodicFixWhII_Standard20*ica fmri.taskCMG.run5.melodicFixWhII_Standard18*ica fmri.taskCMG.run5.melodicFixWhII_Standard15*ica fmri.taskCMG.run5.melodicFixWhII_Standard10*ica"
   suffixListMelodicFixTaskRun6="fmri.taskCMG.run6.melodicFixStandard20*ica fmri.taskCMG.run6.melodicFixStandard18*ica fmri.taskCMG.run6.melodicFixStandard15*ica fmri.taskCMG.run6.melodicFixStandard10*ica fmri.taskCMG.run6.melodicFixWhII_Standard20*ica fmri.taskCMG.run6.melodicFixWhII_Standard18*ica fmri.taskCMG.run6.melodicFixWhII_Standard15*ica fmri.taskCMG.run6.melodicFixWhII_Standard10*ica"
   suffixList="${suffixListAnat} ${suffixListQC} ${suffixListFmri} ${suffixListMelodicFixNone} ${suffixListMelodicFixRest} ${suffixListMelodicFixTaskRun1} ${suffixListMelodicFixTaskRun2} ${suffixListMelodicFixTaskRun3} ${suffixListMelodicFixTaskRun4} ${suffixListMelodicFixTaskRun5} ${suffixListMelodicFixTaskRun6}"
   rm -f /tmp/missingOutputList.txt
   echo ""
   echo "Checking sessions for completeness:"
   echo ""
   sessionList="${1}"
   for session in `echo "${sessionList}"`; do
      echo ""
      echo "File and diredtory sizes in session $session:"
      for suffix in ${suffixList}; do
         if [ -s ${projDir}/derivedData/${session}/*${suffix} ]; then
            du -sh ${projDir}/derivedData/${session}/*${suffix}
         else
            echo "${projDir}/derivedData/${session}/*${suffix}" >> /tmp/missingOutputList.txt
         fi
      done
   done

echo ""
echo "Missing products from sessionList ${sessionList}:"
echo ""
cat /tmp/missingOutputList.txt
}


export projDir="/data/panolocal/processedOnPano-nocera"
export scriptDir="/home/stowler-local/src.mywork.gitRepos/proj.jn.cda2"

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
export sessions2015NovExercise="${sessions2015NovExercisePre} ${sessions2015NovExercisePst}"
#echo $sessions2015NovExercisePre
#echo $sessions2015NovExercisePst
#echo $sessions2015NovExercise


#export sessions2015NovControlPst="${sessionsTypicalControlPst}"
#export sessions2015NovControlPre="`echo ${sessions2015NovControlPst} | sed 's/pst/pre/g'`"
#export sessions2015NovControl="${sessions2015NovControlPre} ${sessions2015NovControlPst}"
#echo "sessions2015NovControlPre:"
#echo $sessions2015NovControlPre
#echo "sessions2015NovControlPst"
#echo $sessions2015NovControlPst
#echo "sessions2015NovControl"
#echo $sessions2015NovControl




#!!!!!!!!!!!!!!!!
# NB: on OS X but not linux, sed doesn't respect the \n below, and needs to be
# replaced with a call to gsed. Echo may also need to be replaced with echo -e
# (TBD).
#!!!!!!!!!!!!!!!!
# convert lists from rows to columns for other use:
#export sessionsTypical_column="`echo ${sessionsTypical} | sed 's/ /\n/g'`"
#echo "$sessionsTypical_column"


#fxnCheckSessions "$sessions2015NovControlPre"
