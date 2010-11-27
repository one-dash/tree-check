#!/bin/sh

source "$(which tree-paths.sh)"

# generate tree
if [ -a "${TREEFILENAME}" ]; then
  rm -f "${TREEFILENAME}"
fi
echo generating tree...
find . -type f | sort > "${TREEFILENAME}"
# sign tree. The signing happens w/ the default key. You are asked about your
# password
echo signing tree...
gpg -a -s "${TREEFILENAME}"
# make hashes of files
if [ -a "${HASHTREEFILENAME}" ]; then
  rm -f "${HASHTREEFILENAME}"
fi
echo writing file hash sums...
find . -type f -print0 | xargs -0 -L1 sha512sum > "${HASHTREEFILENAME}"
# sign hashes
gpg -a -s "${HASHTREEFILENAME}"
