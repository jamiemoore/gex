#!/bin/bash
###############################################################################
# build.sh - build script for Gex 
###############################################################################
set -euo pipefail
IFS=$'\n\t'
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=$(git describe)

go install  -ldflags "-X main.version=$VERSION"
cp -p /go/bin/gex /go/src/github.com/jamiemoore/gex/bin/
