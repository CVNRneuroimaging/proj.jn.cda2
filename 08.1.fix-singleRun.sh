#!/bin/bash

# 08.1.fix-singleRun.sh

# Applying FIX to a single melodic output directory should take fewer than 10 minutes on most modern hardware:

############# arguments: ############
#...structured to allow this script to be easly called by external parllel
# processor such as GNU parallel or ppss
#
# TBD: test passed values

# the melodic output directory that we'll copy for fix i/o
# example: /data/panolocal/processedOnPano-nocera/derivedData/cda001pre/cda001pre.fmri.taskCMG.run1.melodicFixNone.ica
melodicOut=$1

# the existing trained-weights file that will be used to classify components
# example: /opt/fix/training_files/Standard.RData
fixWeightsFile=$2

# the fix threshold
# example: 20
fixThresh=$3

# how this script is being executed. just affects output naming.
# example: serial, parallel.gnu, parallel.ppss, parallel.tmux, gnuParallel10
execution=$4

# get basename so it can be used in stdout/logs:
fixInName="`basename ${melodicOut}`"

# construct name of fix input/output dir
fixWeightsName=`basename ${fixWeightsFile} | sed 's/\.RData//'`
melodicBasename="`basename ${melodicOut} | sed 's/\.melodicFixNone\.ica//'`"      # ...e.g., "cda001pre.fmri.taskCMG.run1"
fixDirName=${melodicBasename}.melodicFix${fixWeightsName}${fixThresh}-${execution}.ica            # ...e.g., "cda001pre.fmri.taskCMG.run1.melodicFixStandard20.ica"

# the fix input/output directory will be sibling to the original melodic directory:
fixDirParent="`dirname ${melodicOut}`"

# Create a copy of the original non-fix melodic .ica output. Will use the copy for fix input/output:
cp -r ${melodicOut} ${fixDirParent}/${fixDirName}

# run fix:
echo ""
echo "######################################"
date
echo "Launching FIX:"
echo "MELODIC dir:      ${fixInName}"
echo "trained-weights:  ${fixWeightsName}"
echo "FIX threshold:    ${fixThresh}"
echo -n "FIX version:      "
which fix | xargs dirname | xargs ls -l
echo "######################################"
echo ""
/usr/bin/time fix ${fixDirParent}/${fixDirName} ${fixWeightsFile} ${fixThresh} -m
echo ""
date
echo "FIX complete for thresh ${fixThresh} of ${fixInName}."
du -sh ${fixDirParent}/${fixDirName}
echo ""
