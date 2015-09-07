#!/bin/sh

# generate QC report for one nocera fmri category member generation (cmg)
# session (6 runs per session)

# INPUT: session-level nifti directory containing *-fmri.taskCMG.run?.bxh
# e.g., /data/panolocal/processedOnPano-nocera/derivedData/cda001pre , 
# which contains ./bxh+orig/cda001pre.fmri.taskCMG.run?.ortOrig.bxh


# receive and parse the input:
niftiDirSession=$1
sessionName=`basename ${niftiDirSession}`
bxhFiles="`ls ${niftiDirSession}/bxh+orig/*fmri.taskCMG.run?.bxh`"


# set output directory, which will be created by fmriqa_generate.pl as long as
# the parent dir exists:
qcOutputDir=${niftiDirSession}/qcReport-FBIRN-taskCMG


# inform stdout: 
echo ""
echo "#####################################################"
echo "Executing fmriqa_generate.pl for:"
echo "\$niftiDirSession = ${niftiDirSession}"
du -sh ${niftiDirSession}
echo "\$sessionName = ${sessionName}"
echo "\$bxhFiles = ${bxhFiles}"
du -sh ${bxhFiles}
echo "\$qcOutputDir (to be created by fmriqa_generate.pl) = ${qcOutputDir}"


# execute:
fmriqa_generate.pl ${bxhFiles} ${niftiDirSession}/qcReport-FBIRN-taskCMG
