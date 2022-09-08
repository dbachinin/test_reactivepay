require 'json'
require './send_request'

class Payments
  def initialize(amount:, currency:, token: ENV['TOKEN'])
    @amount = amount
    @currency = currency
    @token = token
  end

  def create
    uri = '/api/v1/payments'
    result = SendRequest.request(params, uri: uri, token: @token)
    JSON.parse(result.body) if result.status == 200

    error_body = JSON.parse(result.body)
    raise "Could not create payment with status #{result.status} #{error_body['errors']}"
  end

  def params
    {
      product: 'My Product',
      amount: @amount,
      currency: @currency,
      redirectSuccessUrl: 'https://my-site.com/success',
      redirectFailUrl: 'https://my-site.com/fail',
      extraReturnParam: 'my order id or other info',
      orderNumber: '123',
      locale: 'en'
    }
  end
end
