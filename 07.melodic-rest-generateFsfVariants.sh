#!/bin/sh

# 07.melodic-rest-generateFsfVariants.sh 
#
# Use existing melodic fsf files from a single session to generate melodic fsf
# files for many sessions.
#
# Assumes pwd is parent directory of a child directory that contains
# per-session fsf files. For example:
# 
# $ pwd
# /home/stowler-local/src.mywork.gitRepos/proj.jn.cda2/melodic-fsfFiles-rest
# 
# $ tree -L 2 | head
# .
# └── cda001pre-fsfFiles-rest
#     └── cda001pre.fmri.rest.run1.melodicFixNone_design.fsf
#
#

# sessionIDlist for rama re-processing 20150903-10,  and maybe later:
# ...NB: I'm omitting the template (cda001pst) from this list to avoid recursion:
# ...NB: for now I'm omitting sessions with atypical timing (210 two-second TRs): cda001pre, cda002pre, cda100pre
# ...NB: for now I'm omitting sessions with missing rest: cda004pst
# ...NB: for now I'm omitting sessions with anatomic problems: cda106pre
sessionIDlist="cda002pst cda003pre cda003pst cda004pre cda005pre cda005pst cda006pre cda006pst cda007pre cda007pst cda008pre cda008pst cda009pre cda010pre cda010pst cda011pre cda012pre cda013pre cda100pst cda101pre cda101pst cda102pre cda102pst cda103pre cda103pst cda104pre cda104pst cda105pre cda107pre cda108pre cda109pre cda109pst"

# directory containing single-session fsf files that will act as template for
# other sessions:
#fsfTemplateDir=cda001pre-fsfFiles-rest
fsfTemplateDir=cda001pst-fsfFiles-rest

for sessionID in `echo ${sessionIDlist}`; do
   newSessionID="$sessionID"

   # create a copy of the existing template directory:
   newFsfDir=${newSessionID}-fsfFiles-rest
   cp -r ${fsfTemplateDir} ${newFsfDir}

   # change fsf file names to reflect new sessionID:
   for file in ${newFsfDir}/*.fsf; do 
      fsfBasename=`basename ${file}`
      fsfSuffix=`echo ${fsfBasename} | sed 's/cda.......//g'`
      #echo "fsfBasename is ${fsfBasename}"
      #echo "fsfSuffix is ${fsfSuffix}"
      mv ${file} ${newFsfDir}/${newSessionID}.${fsfSuffix}
   done

   # change the filepaths inside of the fsf file to reflect the newSessionID:
   for file in ${newFsfDir}/*.fsf; do
      du -sh $file
      sed -i '' "s/cda001pst/${newSessionID}/g" $file
      ls -al $file
   done

done

