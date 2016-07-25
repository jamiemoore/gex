#!/bin/bash
###############################################################################
# build.sh - build script for Gex 
###############################################################################
set -euo pipefail
IFS=$'\n\t'
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#go get
go install
cp -p /go/bin/gex /go/src/github.com/jamiemoore/gex/bin/
