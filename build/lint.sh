#!/bin/bash
###############################################################################
# lint.sh - lint 
###############################################################################
set -euo pipefail
IFS=$'\n\t'
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

go fmt
golint 
