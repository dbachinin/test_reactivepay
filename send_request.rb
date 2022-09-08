require 'faraday'

class SendRequest
  PROFILE_TOKEN = '42539aa22be32841f737'.freeze
  class << self
    def request(body, uri:, req_type: :post)
      url = 'https://business.reactivecloud.io' + uri
      Faraday.new(url: url).send(req_type) do |req|
        req.headers['Authorization'] = "Bearer #{PROFILE_TOKEN}"
        req.headers['Content-Type'] = 'application/json'
        req.options.timeout = 90
        req.body = body.to_json
      end
    end
  end
end
