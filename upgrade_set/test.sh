#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -e
set -o allexport
. ../../conf/env/cf.env
. ../../conf/i18/upgrade.sh
set +o allexport
set -x

./src/mod.coffee
