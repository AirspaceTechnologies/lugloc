require "lugloc/version"
require 'net/https'
require 'json'


module Lugloc
  module_method def get_location(
      token: get_token,
      **c
  )
  end

  module_method def call_api(
    device_id:,
    path: '',
    lugloc_url: 'https://api.lugloc.com/api',
    net_method: Net::HTTP::Get,
    token: get_token,
    **c
  )
  uri = URI.join(lugloc_url, path)
  req = net_method.new(uri)
  req['Authorization'] = "Bearer #{token}"

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  res = http.request(req)

  return res.body, res
  end




  private

  # Note that we do no error handling here
  def get_token(
      lugloc_token_url: 'https://api.lugloc.com/Token',
      token_grant_type: 'password',
      lugloc_username:  ENV['lugloc_api_username'],
      lugloc_password:  ENV['lugloc_api_password'],
      lugloc_client_id: ENV['lugloc_client_id'],
      lugloc_secret:    ENV['lugloc_secret'],
      **c
  )
    Net::HTTP.post_form(
      URI(token_uri),
      grant_type:    token_grant_type,
      username:      lugloc_username,
      password:      lugloc_password,
      client_id:     lugloc_client_id,
      client_secret: lugloc_secret
    )

    j = JSON.parse(r.body)
    j['access_token']
  end
end
