require "lugloc/version"
require 'net/https'
require 'json'


module Lugloc
  module_method def get_location(**c)
    call_get(
        path: '',
        **c
    )
  end

  module_method def get_history(**c)
    call_get(
        path: 'locationHistory',
        **c
    )
  end

  module_method def refresh_location(**c)
    call_post(
        path: 'refreshlocation',
        **c
    )
  end

  module_method def turn_off(
    minutes:,
    **c
  )
    call_post(
        query: {'minutes' => minutes},
        path: 'turnOff',
        **c
    )
  end




  private

  module_method def call_get(**c)
    call_api(
        net_method: Net::HTTP::Get,
        **c
    )
  end

  module_method def call_post(**c)
    call_api(
      net_method: Net::HTTP::Post,
      **c
    )
  end

  module_method def call_api(
    device_id:,
    net_method:,
    path:,
    query: {},
    lugloc_url: 'https://api.lugloc.com/api',
    token: get_token,
    **c
  )

    uri = URI.join(lugloc_url, "/#{device_id}/#{path}")
              .query(URI.encode_www_form(query))
    req = net_method.new(uri)
    req['Authorization'] = "Bearer #{token}"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    res = http.request(req)

    return res.body, res
  end

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
