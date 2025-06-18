#!/usr/bin/env coffee

> ./releaseLs.js
  path > basename join
  fs > createWriteStream rmSync mkdirSync

< (owner, repo, tag, to_dir) =>
  url_li = await releaseLs(owner, repo, tag)
  rmSync to_dir, { recursive: true, force: true }
  mkdirSync(to_dir, { recursive: true })
  console.log url_li
  Promise.all url_li.map (url)=>
    fp = join to_dir, basename(url)
    r = await fetch(url)
    stream = createWriteStream fp
    console.log r.status


    return

