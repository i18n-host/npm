#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -e
set -o allexport
. ../../conf/env/cf.env
. ../../conf/i18/upgrade.sh
set +o allexport
set -x

TXT="1 x 2l3232" ./src/mod.coffee i18 nightly
