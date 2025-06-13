#!/usr/bin/env coffee

> @8v/curl

{DOWN_HOST_LI} = process.env


export default warmup = (
  project
  ver
  platform
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

  await Promise.allSettled url_li.map (host)=>
    url = "https://#{host}/#{project}/#{ver}/#{platform}.tar"
    try
      r = await curl(url)
    catch err
      err_li.push ['❌',url,err.toString()]
      return
    console.log host, r.status, r.headers.get('content-length')
    return

  for i from err_li
    console.error ...i
  return err_li.length

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await warmup 'i18','0.1.41','x86_64-unknown-linux-musl'
