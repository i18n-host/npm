#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
set -e
cd $DIR/../../conf/env
set -o allexport
. cf.env
. github.env
. upgrade.env
set +o allexport
cd $DIR
set -x

bun x cep -c src -o lib

./lib/warmup.js
# ver=0.1.41
# ./lib/mod.js i18 $ver ../../conf/env/upgrade/sk /tmp/bin/i18/0.1.19/aarch64-apple-darwin
