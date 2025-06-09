> @3-/ossput
  fs > createReadStream
  path > basename

HTTPS = 'https://'

{S3_LI} = process.env

put = ossput S3_LI.split(' ').map (i)=>
  [
    endpoint
    accessKeyId
    secretAccessKey
    bucket
    download_prefix
  ] = i.split(';')

  [
    bucket
    {
      credentials:{
        accessKeyId
        secretAccessKey
      }
      endpoint: HTTPS+endpoint
    }
    HTTPS+download_prefix
  ]


export default (project, version, out_tar) =>
  put(
    [
      project
      version
      basename out_tar
    ].join('/')
    =>
      createReadStream(out_tar)
  )
