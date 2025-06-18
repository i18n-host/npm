> @8v/curl/cJson.js

export default (org, repo, tag, to_dir) =>
  r = await cJson(
    "https://api.github.com/repos/#{org}/#{repo}/releases/tags/#{tag}"
  )
  for i from r.assets
    console.log i.browser_download_url
  return
