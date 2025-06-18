> @8v/curl/cJson.js

export default (org, repo, tag, to_dir) =
>
  api_url = "https://api.github.com/repos/#{repo}/releases/tags/#{tag}"

  console.log {
    org
    repo
    tag
    to_dir
  }
