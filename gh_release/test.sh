#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -e
set -o allexport
. ../../conf/env/github.env
set +o allexport
set -x

mise exec -- ./test.coffee
