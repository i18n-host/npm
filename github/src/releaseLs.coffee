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

  r.data.assets.map (i)=>
    i.browser_download_url
