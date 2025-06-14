#!/usr/bin/env coffee

> @8v/curl
  @3-/sleep
  fs > statSync
  @3-/retry
  ./numLi.js

retryCurl = retry curl

{DOWN_HOST_LI} = process.env

CONTENT_LENGTH = 'content-length'

warmup = (
  project
  ver
  platform
  size
)=>
  url_li = []

  for i in DOWN_HOST_LI.split(';')
    first_char = i.charAt(0)

    if first_char >= 'A' and first_char <= 'Z'
      continue

    m = i.match /^(.*)\[([^\]]*)](.*)$/
    if m
      [_, prefix, range, remain] = m
      for i in numLi(range)
        url_li.push "#{prefix}#{i}#{remain}"
    else
      url_li.push "#{i}"

  err_li = []

  url_li = url_li.map (host)=>
    "https://#{host}/#{project}/#{ver}/#{platform}.tar"

  retryed = 30
  loop
    next_li = []
    await Promise.allSettled url_li.map (url)=>
      try
        r = await retryCurl(url)
      catch err
        err_li.push ['❌',url,err.toString()]
        return
      filesize = +(r.headers.get(CONTENT_LENGTH) or 0)
      if filesize == size
        return
      if filesize
        err_li.push ['❌',r.status,url,CONTENT_LENGTH,filesize,'!=',size]
      else
        console.log r.status, url, 'size', filesize
        # wait for perpare
        next_li.push url
      return

    if next_li.length == 0
      break

    if --retryed < 0
      err_li.push ['❌',next_li.join('/'),'NO',CONTENT_LENGTH]
      break

    await sleep 1e4
    url_li = next_li

  for i from err_li
    console.error ...i
  return err_li.length

export default (
  project
  ver
  platform
  tar_path
)=>
  warmup(
    project
    ver
    platform
    statSync(tar_path).size
  )

await warmup 'i18','0.1.41','x86_64-unknown-linux-musl',4077056
