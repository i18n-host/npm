HTTPS = 'https://'

{S3_LI} = process.env

S3_LI = S3_LI.split(' ').map (i)=>
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
      endpoint: HTTPS+url
    }
  ]

console.log S3_LI
export default (project, version, out_tar) =>
  console.log project, version, out_tar
  # [
  #   [
  #     bucket
  #     {
  #       credentials:{
  #         accessKeyId
  #         secretAccessKey
  #       }
  #     }
  #     endpoint: HTTPS+url
  #   ]
  # ]
  return
