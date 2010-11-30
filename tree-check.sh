#!/bin/sh

source $(which tree-paths.sh)

which diff
which more

# check hashes signature
gpg --verify "${HASHTREEFILENAME}".asc
# check file tree signature
gpg --verify "${TREEFILENAME}".asc

set +e

find . -type f | \
  fgrep -v "${TREEFILENAME}" | \
  fgrep -v "${TREEFILENAME}".asc | \
  fgrep -v "${HASHTREEFILENAME}" | \
  fgrep -v "${HASHTREEFILENAME}".asc | \
  sort | \
  diff --suppress-common-lines -u \
    --label 'previous tree' "${TREEFILENAME}" \
    --label 'current tree' - | more

# check hashes
echo checking hashes...
sha512sum -c --quiet "${HASHTREEFILENAME}"
