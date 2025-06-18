#!/usr/bin/env coffee

> ./mod.js > GH

< (owner, repo, tag) =>
  r = await GH.repos.getReleaseByTag({
    owner
    repo
    tag
  })
  if r.status != 200
    console.error r
    return
  for i from r.data.assets
    console.log i.browser_download_url
    console.log i.name
  # await mkdir tag, { recursive: true }
  # for asset in rel.assets
  #   console.log "↓ #{asset.name}"
  #   await down asset.url, join(tag, asset.name)
  return
