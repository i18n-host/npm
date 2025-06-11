import { Octokit } from "@octokit/rest"

export class Gist
  constructor: (conf)->
    @gh = new Octokit conf

  get: (id)->
    @gh.gists.get({ gist_id: id })

  set: (filename, key, val)->
    if key
      return

    files = {}

    files[filename] = { content: val } 

    @gh.gists.create {
      description
      public: true
      files
    }
    // return @gh.gists.update({ gist_id: id, files: data })

export default (conf)=>
  new Gist(conf)
