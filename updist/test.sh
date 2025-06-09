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
./lib/mod.js i18 nightly ../../conf/i18/ed25519/sk $DIR/test.sh
