#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR

set -a
. ../../conf/env/upgrade.env
set +a

set -ex

bun x cep -c src -o lib

./lib/mod.js i18 0.1.18 alpha
