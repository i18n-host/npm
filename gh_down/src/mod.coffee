> @8v/curl/cJson.js
  fs > rmSync mkdirSync
  path > basename join

export ghReleaseUrlLi = (org, repo, tag)=>
  r = await cJson(
    "https://api.github.com/repos/#{org}/#{repo}/releases/tags/#{tag}"
  )
  r.assets.map (i)=>
    i.browser_download_url

export default (org, repo, tag, to_dir) =>
  li = await ghReleaseUrlLi(
    org, repo, tag
  )
  mkdirSync to_dir, { recursive: true }
  Promise.all(
    li.map (url)=>
      to_file = join to_dir, basename url
      console.log to_file
      # curl(
      #   url, to_dir
      # )
  )
