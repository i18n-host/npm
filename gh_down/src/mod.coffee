> @8v/curl/cJson.js

export default (org, repo, tag, to_dir) =>
  r = await cJson(
    "https://api.github.com/repos/#{org}/#{repo}/releases/tags/#{tag}"
  )
  console.log r
