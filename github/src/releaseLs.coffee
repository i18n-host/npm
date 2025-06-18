#!/usr/bin/env coffee

> ./mod.js > GH

< (owner, name, tag) =>
  r = await GH.repos.getReleaseByTag({
    owner
    repo: name
    tag
  })
  console.log r
  # await mkdir tag, { recursive: true }
  # for asset in rel.assets
  #   console.log "↓ #{asset.name}"
  #   await down asset.url, join(tag, asset.name)
  return
