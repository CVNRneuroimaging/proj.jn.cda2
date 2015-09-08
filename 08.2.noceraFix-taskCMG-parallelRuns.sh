#!/bin/sh

parallelFixRuns=$1
niftiDirProject=/data/panolocal/processedOnPano-nocera/derivedData
ls -d ${niftiDirProject}/cda*/*taskCMG*melodicFixNone.ica | parallel --jobs ${parallelFixRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.jn.cda2/08.1.noceraFix-singleRun.sh {} /opt/fix/training_files/Standard.RData 20 gnuParallel
