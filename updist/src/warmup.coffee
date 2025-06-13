#!/usr/bin/env coffee

> @8v/curl

{DOWN_HOST_LI} = process.env

project = "i18"
ver = "0.1.41"
platform = "x86_64-unknown-linux-musl"

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
    err_li.push [i,err.toString()]
    return
  console.log host, r.status
  return

if err_li.length
  for i from err_li
    console.error ...i
