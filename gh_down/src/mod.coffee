> @8v/curl/cJson.js
  fs > rmSync mkdirSync createWriteStream
  path > basename join
  @3-/wget

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
  Promise.all(
    li.map (url)=>
      wget(
        url
        join to_dir, basename url
      )
  )
