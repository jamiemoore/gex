#!/bin/bash
###############################################################################
# test.sh - test script for Gex 
###############################################################################
set -euo pipefail
IFS=$'\n\t'
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

go test -v -cover
