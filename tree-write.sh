#!/bin/sh

source "$(which tree-paths.sh)"

# generate tree excluding tree, hashes and signature
if [ -a "${TREEFILENAME}" ]; then
  rm -f "${TREEFILENAME}"
fi
echo generating tree...
find . -type f | \
  fgrep -v "${TREEFILENAME}" | \
  fgrep -v "${TREEFILENAME}".asc | \
  fgrep -v "${HASHTREEFILENAME}" | \
  fgrep -v "${HASHTREEFILENAME}".asc | \
  sort > "${TREEFILENAME}"
# sign tree. The signing happens w/ the default key. You are asked about your
# password
echo signing tree...
gpg -a -s "${TREEFILENAME}"
# make hashes of files
if [ -a "${HASHTREEFILENAME}" ]; then
  rm -f "${HASHTREEFILENAME}"
fi
echo writing file hash sums...
find . -type f\
  \! -path "${TREEFILENAME}"\
  \! -path "${TREEFILENAME}".asc\
  \! -path "${HASHTREEFILENAME}"\
  \! -path "${HASHTREEFILENAME}".asc -print0 |\
  xargs -0 -L1 sha512sum > "${HASHTREEFILENAME}"
# sign hashes
gpg -a -s "${HASHTREEFILENAME}"
