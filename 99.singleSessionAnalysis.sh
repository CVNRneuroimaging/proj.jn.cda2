#!/bin/bash

# 99.singleSessionAnalysis.sh
# 
# Calling this script for a single session executes all of the individual steps
# necessary to create all of the session's derivedData from the session's
# acqfiles.
#
# NB: please note the intentional lack of parallelization in this script.
# Because it's highly likely that multiple single-session analyses will be run
# in parallel, I intend for users to control their use of pooled CPU/RAM by
# controlling the nuber of parallel sessions. Allowing within-session
# parallelization would produce much less predictable resource utilization
# during execution of parallel sessions.

session=$1

echo ""
echo ""
echo "Starting single-session processing of $session (i.e., making derivedData from acqfiles)"
date
echo ""
echo ""



# source 00.projectEnvironment.sh to get $projDir and $scriptDir:
# (e.g., projDir=/data/panolocal/processedOnPano-nocera)
. 00.projectEnvironment.sh
echo "projDir is $projDir"
echo "scriptDir is $scriptDir"



#########################################################################
# TESTS: are input files or output targets going to be a problem?
#

# Is there an acqfiles directory?
# ...no: warn and exit.
# ...yes: continue.
if [ ! -d ${projDir}/acqfiles-nifti/${session} ]; then
   echo ""
   echo "Exiting because session ${session} acqfiles-nifti directory does not seem to exist:"
   echo "${projDir}/acqfiles-nifti/${session}"
   exit 1
else
   echo ""
   echo "Inputs are acquistion files formatted as niftis:"
   du -sh ${projDir}/acqfiles-nifti/${session}
fi

# Does the acqfiles directory have the expected files?
# ...no: warn and exit.
# ...yes: continue.
inputSuffixes="anat.nii.gz fmri.rest.run1.nii.gz fmri.taskCMG.run1.nii.gz fmri.taskCMG.run2.nii.gz fmri.taskCMG.run3.nii.gz fmri.taskCMG.run4.nii.gz fmri.taskCMG.run5.nii.gz fmri.taskCMG.run6.nii.gz"
for inputSuffix in ${inputSuffixes}; do
   inputFile="${projDir}/acqfiles-nifti/${session}/${session}.${inputSuffix}"
   if [ ! -s ${inputFile} ]; then
      echo ""
      echo "Exiting because session ${session} seems to be missing at least one input file:"
      echo "${inputFile}"
      exit 1
   else
      du -sh ${inputFile}
   fi
done

# Is there a manual center of gravity in source control?
# ...no: warn and exit.
# ...yes: continue.
manualCOG="${scriptDir}/t1anat-manualCOG/${session}-manualCOG.txt"
if [ ! -s ${manualCOG} ]; then
   echo ""
   echo "Exiting because session ${session} seems to be missing the text file containing its manually-specified T1 anatomic center-of-gravity:"
   echo "${manualCOG}"
   exit 1
else
   echo ""
   echo "derivedData will symlink to this manually-specified T1 anatomic center-of-gravity:"
   du -sh ${manualCOG}
fi

# Is there already a session directory in derivedData?
# ...yes: warn and exit
# ...no:  create the directory and continue
sessionDir=${projDir}/derivedData/${session}
if [ -d ${sessionDir} ]; then
   echo ""
   echo "Exiting because session ${session} seems to already have an existing output directory:"
   du -sh ${sessionDir}
   exit 1
else
   mkdir ${sessionDir}
   if [ $? -ne 0 ]; then 
      echo ""
      echo "Exiting because of failure to create directory for single-session outputs:"
      echo "${sessionDir}"
      exit 1
   else
      echo ""
      echo "Created directory for single-session outputs:"
      echo "${sessionDir}"
   fi
fi


#########################################################################
# Anatomic operations:
#

# Link to manual center of gravity in source control:

# Skull strip a single session using stock bet with manual center-of-gravity:

# Skull strip using experimental optiBET (experimental for us, currently):



#########################################################################
# Generate quality control data:
#


# Generate FBIRN QC report for FMRI task:

# Generate FBIRN QC report for FMRI rest:



#########################################################################
# Generate initial MELODIC .ica directories (no FIX):
#

# Generate initial MELODIC .ica directory for FMRI task (no FIX):

# Generate initial MELODIC .ica directory for FMRI rest (no FIX):



#########################################################################
# Run FIX using the FSL trained-weights Standard file, and a range of FIX
# thresholds:
#


# Run FIX Standard20 for FMRI task:
# Run FIX Standard20 for FMRI rest:

# Run FIX Standard18 for FMRI task:
# Run FIX Standard18 for FMRI rest:

# Run FIX Standard15 for FMRI task:
# Run FIX Standard15 for FMRI rest:

# Run FIX Standard10 for FMRI task:
# Run FIX Standard10 for FMRI rest:


#########################################################################
# Run FIX using the FSL trained-weights WhII_Standard file, and a range of FIX
# thresholds:
#

# Run FIX WHII_Standard20 for FMRI task:
# Run FIX WHII_Standard20 for FMRI rest:

# Run FIX WHII_Standard18 for FMRI task:
# Run FIX WHII_Standard18 for FMRI rest:

# Run FIX WHII_Standard15 for FMRI task:
# Run FIX WHII_Standard15 for FMRI rest:

# Run FIX WHII_Standard10 for FMRI task:
# Run FIX WHII_Standard10 for FMRI rest:

