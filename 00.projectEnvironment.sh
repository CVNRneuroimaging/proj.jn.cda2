#!/bin/bash

# 00.projectEnvironment.sh
#
# setup environment for subsequent scripts

export projDir="/data/panolocal/processedOnPano-nocera"
export scriptDir="~stowler-local/src.mywork.gitRepos/proj.jn.cda2"


# typical sessions per: 
#   1 anat
#   1 rest
#   6 fmritaskCMG


# exercise participants are cda0XX:
export sessionsTypicalExercisePre="cda001pre cda002pre cda003pre cda004pre cda005pre cda006pre cda007pre cda008pre cda010pre cda011pre cda012pre cda013pre"
export sessionsTypicalExercisePst="cda001pst cda002pst cda003pst cda005pst cda006pst cda007pst cda008pst cda010pst"
export sessionsTypicalExercise="${sessionsTypicalExercisePre} ${sessionsTypicalExercisePst}"

# control participants are cda1XX:
export sessionsTypicalControlPre="cda100pre cda101pre cda102pre cda103pre cda104pre cda105pre cda107pre cda108pre cda109pre"
export sessionsTypicalControlPst="cda100pst cda101pst cda102pst cda103pst cda104pst cda109pst"
export sessionsTypicalControl="${sessionsTypicalControlPre} ${sessionsTypicalControlPst}"

# combine exercise and control ino single list:
export sessionsTypical="${sessionsTypicalExercise} ${sessionsTypicalControl}"

# atypical sessions per above:
#
# cda004pst - missing rest
# cda009pre - missing anat in derivedData
# cda106pre - missing anat in derivedData
# cda011pre and cda011pst - potential pre/post confusion needs to be re-confirmed
# cda011pst - acquired three runs instead of six (eprime issues)
export sessionsAtypical="cda004pst cda009pre cda011pre cda011pst cda106pre"

# convert lists from rows to columns for other use:
export sessionsTypical_column="`echo ${sessionsTypical} | sed 's/ /\n\n/g'`"
echo "$sessionsTypical_column"
# export subjsYoung_column="`echo ${subjsYoung} | sed 's/ /\n/g'`"
# export subjsOld_column="`echo ${subjsOld} | sed 's/ /\n/g'`"
# export subjs="`echo ${subjsYoung}` `echo ${subjsOld}`"
# export subjs_column="`echo ${subjs} | sed 's/ /\n/g'`"

# echo ""
# echo "studyDir=${studyDir}"
# echo "outDir=${outDir}"
# echo "subjsYoung=${subjsYoung}"
# echo "subjsOld=${subjsOld}"
# echo "subjs=${subjs}"
# echo ""
# echo "Same subject lists, but as columns:"
# echo ""
# echo "subjsYoung_column="
# echo "${subjsYoung_column}"
# echo ""
# echo "subjsOld_column="
# echo "${subjsOld_column}"
# echo ""
# echo "subjs_column="
# echo "${subjs_column}"
