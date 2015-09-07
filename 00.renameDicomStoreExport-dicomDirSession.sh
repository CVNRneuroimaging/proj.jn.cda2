#!/bin/bash

# The real version of this script is kept outside of the source tree because it
# may contain paths with acquisition dates. This version is here for reference.

# Move dicom dirs exported from dicom store to correct names:
mv /data/tmpJoe/exportedFromDicomStore/Cda001/YYYYMMDD /data/tmpJoe/exportedFromDicomStore/fixedSessionName/cda001pre
