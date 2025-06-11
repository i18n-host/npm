import { Octokit } from "@octokit/rest"

export class Gist
  constructor: (conf)->
    @gh = new Octokit conf

  get: (id)->
    @gh.gists.get({ gist_id: id })

  set: (filename, val, gist_id)->
    if gist_id
      return

    files = {}

    files[filename] = { content: val }

    {data} = await @gh.gists.create {
      # description: ''
      public: true
      files
    }
    data.url

export default (auth)=>
  new Gist({auth})
