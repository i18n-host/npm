#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -e
if [ -n "$1" ]; then
  export PROJECT=$1
else
  echo "USAGE : $0 project_name"
  exit 1
fi

if [ -d "$PROJECT" ]; then
  echo "$PROJECT exists"
  exit 1
fi
set -x

rsync -av _tmpl/ $PROJECT
cd $PROJECT
rpl _tmpl $PROJECT
git add .
git add -u
git commit -m"init $PROJECT"
