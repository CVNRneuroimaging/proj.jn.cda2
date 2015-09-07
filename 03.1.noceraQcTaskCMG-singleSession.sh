#!/bin/sh

# generate QC report for one nocera fmri category member generation (cmg)
# session (6 runs per session)

# INPUT: session-level nifti directory containing *-fmri.taskCMG.run?.bxh
# e.g., /data/panolocal/processedOnPano-nocera/derivedData/cda001pre , 
# which contains ./bxh+orig/cda001pre.fmri.taskCMG.run?.ortOrig.bxh


# receive and parse the input:
niftiDirSession=$1
sessionName=`basename ${niftiDirSession}`

# Set output directory, which will be created by fmriqa_generate.pl as long as
# the parent dir exists. NB: this will be rm -fr'd immediately before executing
# fmriqa_generate.pl.
qcOutputDir=${niftiDirSession}/qcReport-FBIRN-taskCMG

# The following only applies if original dicoms are still available, and in
# their original location, which is unlikely in 99% of cases since this script
# will be executed on nodes not approved for sensitive data:
#bxhFiles="`ls ${niftiDirSession}/bxh+orig/*fmri.taskCMG.run?.ortOrig.bxh`"
# ...see further down for creation of new bxhFiles from FSL-oriented niftis:



# inform stdout: 
echo ""
echo "#####################################################"
echo "Executing fmriqa_generate.pl for:"
echo ""
#echo "\$niftiDirSession = ${niftiDirSession}"
echo "\$niftiDirSession :"
du -sh ${niftiDirSession}
echo ""
echo "\$sessionName : ${sessionName}"
echo ""
echo "\$qcOutputDir (to be created by fmriqa_generate.pl) : "
echo "${qcOutputDir}"
echo "#####################################################"
echo ""
echo "(should take < 10 minutes...)"
echo ""

# create new .bxh files from the fsl/mni-oriented niftis:
rm -fr ${niftiDirSession}/bxh+fslNifti
mkdir ${niftiDirSession}/bxh+fslNifti
for run in ${niftiDirSession}/${sessionName}.fmri.taskCMG.run?.nii.gz; do
   runBasename="`basename ${run} | sed 's/\.nii\.gz//'`"
   analyze2bxh ${run} ${niftiDirSession}/bxh+fslNifti/${runBasename}.bxh
   du -sh ${niftiDirSession}/bxh+fslNifti/${runBasename}.bxh
done
bxhFiles="`ls ${niftiDirSession}/bxh+fslNifti/*.bxh`"

# execute:
rm -fr ${qcOutputDir}
fmriqa_generate.pl ${bxhFiles} ${qcOutputDir}
