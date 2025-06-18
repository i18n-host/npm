#!/usr/bin/env coffee

> zx/globals:
  fs > rmSync mkdirSync

{
  GITHUB_OWNER
  GITHUB_REPO
  GITHUB_TOKEN
} = process.env

TMP = '/tmp/vertxt'

< (project, ver_set) =>
  ver_set.delete '0.1.53'
  to = join TMP,project
  rmSync to, {recursive: true, force: true}
  mkdirSync TMP, {recursive: true}
  cd TMP
  await $"git clone https://github.com/{GITHUB_OWNER}/{GITHUB_REPO}.git"
  console.log project, ver_set

