#!/bin/sh

# 05.1.qc-rest-singleSession.sh
#
# generate QC report for one nocera fmri rest session (1 run per session)

# INPUT: 
# Session-level nifti directory containing FSL MNI reoriented .nii files from
# which new bxh files can be generated to serve as input to fmriqa_generate.pl
# e.g., /data/panolocal/processedOnPano-nocera/derivedData/cda001pre , 
# which contains ./cda001pre.fmri.rest.run1.nii.gz
#
# OUTPUT:
# A new directory containing the html FBIRN QC report.


# receive and parse the input:
niftiDirSession=$1
sessionName=`basename ${niftiDirSession}`


# Set output directory, which will be created by fmriqa_generate.pl as long as
# the parent dir exists:
qcOutputDir=${niftiDirSession}/qcReport-FBIRN-rest


# inform stdout: 
echo ""
echo "#####################################################"
echo "Executing fmriqa_generate.pl for resting state:"
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

# create new .bxh files from the fsl/mni-oriented niftis:
mkdir ${niftiDirSession}/bxh+fslNifti
for run in ${niftiDirSession}/${sessionName}.fmri.rest.run1.nii.gz; do
   runBasename="`basename ${run} | sed 's/\.nii\.gz//'`"   #...e.g., "cda001pre.fmri.rest.run1"
   rm -f ${niftiDirSession}/bxh+fslNifti/${runBasename}.bxh
   analyze2bxh ${run} ${niftiDirSession}/bxh+fslNifti/${runBasename}.bxh
   du -sh ${niftiDirSession}/bxh+fslNifti/${runBasename}.bxh
done
bxhFiles="`ls ${niftiDirSession}/bxh+fslNifti/*fmri.rest.run1.bxh`"
#echo "\$bxhFiles : ${bxhFiles}"

# execute:
echo ""
echo "(should take < 10 minutes...)"
echo ""
rm -fr ${qcOutputDir}
fmriqa_generate.pl ${bxhFiles} ${qcOutputDir}
