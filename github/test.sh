#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -a
. ../../conf/env/github.env
set +a
set -ex

bun x cep -c src -o lib

exec mise exec -- coffee ./test.coffee
