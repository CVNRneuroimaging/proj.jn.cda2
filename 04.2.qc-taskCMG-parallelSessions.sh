#!/bin/sh

# 04.2.qc-taskCMG-parallelSessions.sh

parallelQcRuns=20
niftiDirProject=/data/panolocal/processedOnPano-nocera/derivedData

ls -d ${niftiDirProject}/* | parallel --jobs ${parallelQcRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.jn.cda2/04.1.qc-taskCMG-singleSession.sh {}
