#!/bin/sh

# 05.2.qc-rest-parallelSessions.sh

parallelQcRuns=$1
niftiDirProject=/data/panolocal/processedOnPano-nocera/derivedData

ls -d ${niftiDirProject}/* | parallel --jobs ${parallelQcRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.jn.cda2/05.1.qc-rest-singleSession.sh {}
