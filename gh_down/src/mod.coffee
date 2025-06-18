> @8v/curl/cJson.js


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
  console.log li
  return
