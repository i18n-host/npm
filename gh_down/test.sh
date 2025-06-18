#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
# . ../../conf/env/gh_down.env
set -ex
rm -rf lib
bun x cep -c src -o lib
exec mise exec -- coffee ./test.coffee
