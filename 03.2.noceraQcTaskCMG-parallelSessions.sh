#!/bin/sh

parallelQcRuns=20
niftiDirProject=/data/panolocal/processedOnPano-nocera/derivedData

ls -d ${niftiDirProject}/* | parallel --jobs ${parallelQcRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.jn.cda2/03.1.noceraQcTaskCMG-singleSession.sh {}
