#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
. ../../conf/env/github.env
set -ex
bun x cep -c src -o lib
exec mise exec -- coffee ./test.coffee
