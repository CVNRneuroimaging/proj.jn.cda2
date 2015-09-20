#!/bin/bash

# Use optiBET.sh to skull-strip a single session. Should take about 30 minutes per session.

# example dir structure:
# /data/panolocal/processedOnPano-nocera/derivedData/cda001pre/cda001pre.anat.nii.gz

sessionDir=$1
sessionName=`basename $1`

rm -fr ${sessionDir}/optiBET
mkdir  ${sessionDir}/optiBET
cp ${sessionDir}/${sessionName}.anat.nii.gz ${sessionDir}/optiBET/

# calling optiBET.sh from $PATH, where it is in the $bwDir with first line edited to be #!/bin/bash:
optiBET.sh -i ${sessionDir}/optiBET/${sessionName}.anat.nii.gz -f -d
