#!/bin/bash

# 01.renameDicomStoreExport-dicomDirSeries.sh
#
# Create groomed directories of dicoms for conversion to nifti. "Groomed"
# meaning that each dicomdir name has been set to the name that the eventual
# nifti should take:
#
#     anat
#     fmri.rest.run1
#     fmri.taskCMG.run1
#     fmri.taskCMG.run2
#     fmri.taskCMG.run3
#     fmri.taskCMG.run4
#     fmri.taskCMG.run5
#     fmri.taskCMG.run6


# These are all of the unique dicomdir names that appear in the dicomstore exports:
# 
# $ ls -d /data/tmpJoe/exportedFromDicomStore/fixedSessionName/*/* | xargs basename | sort | uniq
# 
# SEQUENCE NAMES I AM PROCESSING:
# ------------------------------------
#
# t1_mprage_SAG1X1X1
#
# REST_TR3000
# Resting (...but only for cda001pre , cda002pre, and cda100pre)
#
# act_BOLD_NP_RUN1
# act_BOLD_NP_RUN2
# act_BOLD_NP_RUN3
# act_BOLD_NP_RUN4
# act_BOLD_NP_RUN5
# act_BOLD_NP_RUN6
# ...but cda100pre is special:
# SPARSEFMRI      (I split and deleted this: it had 142 slices in single SPARSEFMRI dicomdir instead of 2x71)
# SPARSEFMRI_RUN1 (I created this from "SPARSEFMRI")
# SPARSEFMRI_RUN2 (I created this from "SPARSEFMRI")
# SPARSEFMRI_RUN3
# SPARSEFMRI_RUN4
# SPARSEFMRI_RUN5
# SPARSEFMRI_RUN6
# ...and cda001pre is special too:
# SPARSEFMRI_RUN_1 (I had to re-export this from dicom store with special handling because 88 slices in single dicomdir instead of 71 and aborted 17)
# SPARSEFMRI_RUN_2
# SPARSEFMRI_RUN_3
# SPARSEFMRI_RUN_4
# SPARSEFMRI_RUN_5
# SPARSEFMRI_RUN_6
# ...and cda101pre has these special names:
# ep2d_bold
# ep2d_bold_RUN2
# ep2d_bold_RUN3
# ep2d_bold_RUN4
# ep2d_bold_RUN5
# ep2d_boldRUN6

# Missing sessions in groomed output:
#
# du: /data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion/cda004pst/fmri.rest.run1: No such file or directory
# ...because acquisition was discontinued.
# 
# du: /data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion/cda009pre/anat: No such file or directory
# du: /data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion/cda009pre/fmri.rest.run1: No such file or directory
# ...because are missing anat and rest in my dicomstore also. Weirdly tasaki has them

# du: /data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion/cda106pre/anat: No such file or directory
# ...because missing in my dicomstore also
#
# cda100pre rest is smaller than the normal 116-118 MB
# 80M    /data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion/cda100pre/fmri.rest.run1

# cda002pre rest is smaller than the normal 116-118 MB
# 78M    /data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion/cda002pre/fmri.rest.run1

# cda001pre rest is smaller than the normal 116-118 MB
# 78M    /data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion/cda001pre/fmri.rest.run1



# SEQUENCE NAMES I'M NOT CURRENTLY PROCESSING:
# ------------------------------------------------
#
# AX_FLAIR
# AXIAL_T2_FLAIR (cda101pre...has 35 slices)
# AXIAL_T2 (only for cda101pre)
# DTI_2x2x2_64dir_up
# DTI_2x2x2_64dir_up_ADC
# DTI_2x2x2_64dir_up_ColFA
# DTI_2x2x2_64dir_up_FA
# DTI_2x2x2_64dir_up_TENSOR
# DTI_2x2x2_64dir_up_TRACEW
# Design
# EPI_ax_motor_r21
# EvaSeries_GLM
# Localizers
# Mean_&_tMaps
# MoCoSeries
# PhoenixZIPReport
# gre_field_mapping_3x3x3
# gre_field_mapping_3x3x3_SAG
# gre_field_mapping_AXIAL
# bas_BOLD_NP_RUN1
#     cda010pre
#     cda013pre
# SPARSEFMRI_RUN_1_split_1 (cda001pre only...50 slices)


# SEQUENCE NAMES THAT ARE MYSTERIOUS :
# ------------------------------------
# t2_spc_tra_iso_384
# t2_tse3d_tra_iso_320



fxnGroomOneSession(){
   # parent directory that contains all of a session's individual dicomdirs:
   inputParentDir=/data/tmpJoe/exportedFromDicomStore/fixedSessionName/${sessionName}

   rm -fr ${outputGroomedParent}/${sessionName}
   mkdir -p ${outputGroomedParent}/${sessionName}

   # cycle through each dicomdir and do something based on its name:
   for dicomdir in ${inputParentDir}/*; do
      #du -sh ${dicomdir}
      dicomdirBasename=`basename ${dicomdir}`
      #echo $dicomdirBasename
      case "${dicomdirBasename}" in 
         t1_mprage_SAG1X1X1)
            #echo "t1:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/anat
            du -sh ${outputGroomedParent}/${sessionName}/anat
         ;;
         REST_TR3000|Resting)
            #echo "resting:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/fmri.rest.run1
            du -sh ${outputGroomedParent}/${sessionName}/fmri.rest.run1
         ;;
         act_BOLD_NP_RUN1|SPARSEFMRI_RUN_1|SPARSEFMRI_RUN1|ep2d_bold)
            #echo "cmg1:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run1
            du -sh ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run1
         ;;
         act_BOLD_NP_RUN2|SPARSEFMRI_RUN_2|SPARSEFMRI_RUN2|ep2d_bold_RUN2)
            #echo "cmg2:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run2
            du -sh ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run2
         ;;
         act_BOLD_NP_RUN3|SPARSEFMRI_RUN_3|SPARSEFMRI_RUN3|ep2d_bold_RUN3)
            #echo "cmg3:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run3
            du -sh ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run3
         ;;
         act_BOLD_NP_RUN4|SPARSEFMRI_RUN_4|SPARSEFMRI_RUN4|ep2d_bold_RUN4)
            #echo "cmg4:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run4
            du -sh ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run4
         ;;
         act_BOLD_NP_RUN5|SPARSEFMRI_RUN_5|SPARSEFMRI_RUN5|ep2d_bold_RUN5)
            #echo "cmg5:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run5
            du -sh ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run5
         ;;
         act_BOLD_NP_RUN6|SPARSEFMRI_RUN_6|SPARSEFMRI_RUN6|ep2d_boldRUN6)
            #echo "cmg6:"
            #du -sh ${inputParentDir}/${dicomdirBasename}
            cp -r ${dicomdir} ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run6
            du -sh ${outputGroomedParent}/${sessionName}/fmri.taskCMG.run6
         ;;
      esac
   done
}

fxnIsGroomedSessionComplete(){
   for dicomdir in anat fmri.rest.run1 fmri.taskCMG.run1 fmri.taskCMG.run2 fmri.taskCMG.run3 fmri.taskCMG.run4 fmri.taskCMG.run5 fmri.taskCMG.run6; do
      du -sh ${outputGroomedParent}/${sessionName}/${dicomdir}
   done
}

# parent directory that will receive the approved and renamed dicomdirs:
outputGroomedParent=/data/tmpJoe/exportedFromDicomStore/groomedForNiftiConversion

# run for a single session:
#sessionName=cda101pre
#fxnGroomOneSession

# loop across multiple sessions:
for sessionName in `basename /data/tmpJoe/exportedFromDicomStore/fixedSessionName/*`; do
   #fxnGroomOneSession $sessionName
   fxnIsGroomedSessionComplete $sessionName
done
