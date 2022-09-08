require 'faraday'

class SendRequest
  class << self
    def request(body, uri:, req_type: :post, token: nil)
      url = 'https://business.reactivecloud.io' + uri
      Faraday.new(url: url).send(req_type) do |req|
        req.headers['Authorization'] = "Bearer #{token}"
        req.headers['Content-Type'] = 'application/json'
        req.options.timeout = 90
        req.body = body.to_json
      end
    end
  end
end
