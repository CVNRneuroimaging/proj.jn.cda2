#!/bin/sh

# 08.2.fix-taskCMG-parallelRuns.sh
#
# Applies parallel application of FIX to MELODIC .ica directories via gnu parallel calls to 08.1.fix-singleRun.sh
# Can be used for fmri rest or fmri taskCMG (see below).

##############
# INPUTS
#############
#
# Arguments that can be manipulated between executions:
#
#     The argument after "ls -d" controls what melodic directories will serve as inputs to FIX:
#        ls -d ${niftiDirProject}/cda*/*taskCMG*melodicFixNone.ica    #...for fmri task runs
#        ls -d ${niftiDirProject}/cda*/*rest*melodicFixNone.ica       #...for fmri resting state runs
#
#
#     The penultimate argument controls FIX threshold:
#        20
#        18
#        15
#        10
#
#
#     The third-from-last argument specifies the FIX trained-weights dataset that should be used:
#        /opt/fix/training_files/HCP_hp2000.RData
#        /opt/fix/training_files/Standard.RData
#        /opt/fix/training_files/UKBiobank.RData
#        /opt/fix/training_files/WhII_MB6.RData
#        /opt/fix/training_files/WhII_Standard.RData
#
##############
# OUTPUTS 
#############
#
# New FIX-corrected melodic .ica directory for each input run.  See
# 08.1.fix-singleRun.sh , which parses FIX parameters to name its new
# FIX-corrected .ica directories.
#


# Get the number of parallel jobs from the command line:
#parallelFixRuns=$1
parallelFixRuns=10


# The project root containing melodic .ica directories:
niftiDirProject=/data/panolocal/processedOnPano-nocera/derivedData


# Specify FIX parameters. 
# NB: not receiving $fixThresh from command line argument because of potential
# confusion with commandline argument for $parallelFixRuns:
fixWeightsFile=/opt/fix/training_files/WhII_Standard.RData
fixThresh=10


# Suffix for output .ica directory indicating how processing was performed
# e.g., "gnuParallel10rama" for 10 simultaneous gnu parallel jobs executed on rama
# (arbitrary string...just a way to help troubleshoot output when parallel processing goes awry)
executionSuffix=gnuParallel10

echo ""
echo "###################################################################"
echo "Launching parallel executions of 08.1.fix-singleRun.sh "
echo ""
echo "parallelFixRuns    : $parallelFixRuns"
echo "fixWeightsFile     : $fixWeightsFile"
echo "fixThresh          : $fixThresh"
echo "executionSuffix    : $executionSuffix"
echo "###################################################################"
echo ""

# Use gnu parallel to execute for either (but not both simultaneously):
#
# ...fmri taskCMG runs:
ls -d ${niftiDirProject}/cda*/*taskCMG*melodicFixNone.ica | parallel --jobs ${parallelFixRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.jn.cda2/08.1.fix-singleRun.sh {} ${fixWeightsFile} ${fixThresh} ${executionSuffix}
#
# ...or fmri rest runs:
#ls -d ${niftiDirProject}/cda*/*rest*melodicFixNone.ica   | parallel --jobs ${parallelFixRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.jn.cda2/08.1.fix-singleRun.sh {} ${fixWeightsFile} ${fixThresh} ${executionSuffix}
