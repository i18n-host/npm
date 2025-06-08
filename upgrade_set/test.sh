#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -e
set -o allexport
. ../../conf/env/cf.env
set +o allexport
set -x

./src/mod.coffee
