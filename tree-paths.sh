#!/bin/sh

# exit on any error
set -e

# check whether user has these utils
which find
which fgrep
which gpg
which xargs
which sha512sum

# default file names

TREEFILENAME="./tree"
HASHTREEFILENAME="./sha512"
