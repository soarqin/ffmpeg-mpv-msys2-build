#!/usr/bin/env bash

set -e

ARCH=64
ARCH_PREFIX=mingw-w64-x86_64-

SCRIPT_ROOT=$(realpath $(dirname $0))

. $SCRIPT_ROOT/run.sh
