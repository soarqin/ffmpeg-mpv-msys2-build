#!/usr/bin/env bash

set -e

ARCH=32

SCRIPT_ROOT=$(realpath $(dirname $0))
BUILD_ROOT=$(realpath $SCRIPT_ROOT/../build$ARCH)
BUILD_INSTALL_ROOT=$(realpath $HOME/mingw$ARCH)

. $SCRIPT_ROOT/run.sh
