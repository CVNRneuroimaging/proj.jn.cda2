# proj.jn.cda2

# Encryption notes

As part of PHI/PII removal, the script
`00.renameDicomStoreExports-dicomDirSessions.sh` renames session directories
that have been exported from the PHI/PII-encumbered DICOM store. The
session-level directory names exported from the DICOM store are *expected* to
contain acquisition dates because of the way DICOMs are stored in the
PHI/PII-encumbered DICOM store. When that is true, this anonymizing script
becomes encumbered by a record of the renaming operation: it links the
anonymous session ID with its acquisition date (e.g. `mv cda001_20120325
cda001pre`).

Therefore this script is stored encrypted by AES256 with high-entropy password,
and only decrypted for editing and execution on hosts approved for sensitive data.

Encryption:
```bash
$ gpg \
--cipher-algo AES256 \
--armor \
--symmetric \
00.renameDicomStoreExports-dicomDirSessions.sh
```

Decryption:
```bash
$ gpg \
-o 00.renameDicomStoreExports-dicomDirSessions.sh \
--decrypt \
00.renameDicomStoreExports-dicomDirSessions.sh.asc
```
