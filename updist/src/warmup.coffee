#!/usr/bin/env coffee

> @8v/curl
  @3-/sleep
  fs > statSync
  @3-/retry

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

    m = i.match /^(.*)\[(\d+)-(\d+)\](.*)$/
    if m
      [_, prefix, begin, end, remain] = m
      begin = +begin
      end = +end
      for i in [begin..end]
        url_li.push "#{prefix}#{i}#{remain}"
    else
      url_li.push "#{i}"

  err_li = []

  retry = 100
  loop
    next_li = []
    await Promise.allSettled url_li.map (host)=>
      url = "https://#{host}/#{project}/#{ver}/#{platform}.tar"
      try
        r = await retryCurl(url)
      catch err
        err_li.push ['❌',url,err.toString()]
        return
      filesize = +(r.headers.get(CONTENT_LENGTH) or 0)
      if filesize
        if filesize != size
          err_li.push ['❌',url,CONTENT_LENGTH,filesize,'!=',size]
      else
        # wait for perpare
        next_li.push url
      return

    if next_li.length == 0
      break

    if --retry < 0
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
#   await warmup 'i18','0.1.41','x86_64-unknown-linux-musl',4077056
