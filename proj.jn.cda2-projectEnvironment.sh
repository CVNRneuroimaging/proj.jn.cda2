#!/bin/bash

# proj.jn.cda2-projectEnvironment.sh
#
# setup environment for subsequent scripts

export jnProjDir="/data/panolocal/processedOnPano-nocera"
export jnScriptDir="~stowler-local/src.mywork.gitRepos/proj.jn.cda2"


# typical sessions per: 
#   1 anat
#   1 rest
#   6 fmr.taskCMG
export jnSessionsTypical="cda001pre cda001pst cda002pre cda002pst cda003pre cda003pst cda004pre cda005pre cda005pst cda006pre cda006pst cda007pre cda007pst cda008pre cda008pst cda010pre cda010pst cda011pre cda012pre cda013pre cda100pre cda100pst cda101pre cda101pst cda102pre cda102pst cda103pre cda103pst cda104pre cda104pst cda105pre cda107pre cda108pre cda109pre cda109pst"


# atypical sessions per above:
#
# cda004pst - missing rest
# cda009pre - missing anat in derivedData
# cda106pre - missing anat in derivedData
# cda011pre and cda011pst - potential pre/post confusion needs to be re-confirmed
# cda011pst - acquired three runs instead of six (eprime issues)
export jnSessionsAtypical="cda004pst cda009pre cda011pre cda011pst cda106pre"


# convert both of those subject lists to columns for other use:
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
