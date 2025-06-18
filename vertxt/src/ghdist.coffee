#!/usr/bin/env coffee

> zx/globals:
  path > join
  fs > rmSync mkdirSync
  @3-/gh_down:down

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
  await $"git clone --depth=1 https://#{GITHUB_TOKEN}@github.com/#{GITHUB_OWNER}/#{project}.git"

  await Promise.all(
    [...ver_set].map (ver)=>
      down(
        GITHUB_OWNER
        GITHUB_REPO
        project+'-'+ver
        TMP
      )
  )
  console.log project, ver_set

