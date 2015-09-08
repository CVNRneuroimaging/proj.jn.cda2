#!/bin/sh

parallelQcRuns=$1
niftiDirProject=/data/panolocal/processedOnPano-nocera/derivedData

ls -d ${niftiDirProject}/* | parallel --jobs ${parallelQcRuns} --tag --line-buffer ~stowler-local/src.mywork.gitRepos/proj.jn.cda2/04.1.noceraQcRest-singleSession.sh {}
