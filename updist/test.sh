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
./lib/mod.js i18 0.2.1 ../../conf/i18/ed25519/sk /tmp/bin/i18/0.1.0/aarch64-apple-darwin
