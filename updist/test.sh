#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -e
set -o allexport
. ../../conf/env/cf.env
. ../../conf/i18/upgrade.sh
set +o allexport
set -x

bun x cep -c src -o lib
TXT="1 x 2l3232" ./lib/mod.js i18 nightly
