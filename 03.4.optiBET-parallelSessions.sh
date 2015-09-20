#!/bin/bash

# Use optiBET.sh to skull-strip parallel sessions.

# example dir structure:
# When whole-head anatomic has file and path naming like this:
# /data/panolocal/processedOnPano-nocera/derivedData/cda001pre/cda001pre.anat.nii.gz
# ...then $niftiDirProject should be set to /data/panolocal/processedOnPano-nocera/derivedData
# so that it is easy for gnuParallel to iterate over sessionNames like "cda001pre"


parallelSkullstrips=15
niftiDirProject=/data/panolocal/processedOnPano-nocera/derivedData
#niftiDirProject=$1

echo ""
echo "###################################################################"
echo "Launching parallel executions of 03.3.optiBET-singleSession.sh "
echo ""
echo "parallelSkullstrips: $parallelSkullstrips"
echo "niftiDirProject:     $niftiDirProject"      
echo "###################################################################"
echo ""

ls -d ${niftiDirProject}/* | parallel --jobs ${parallelSkullstrips} --tag --line-buffer ./03.3.optiBET-singleSession.sh {}

