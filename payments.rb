require 'json'
require './send_request'

class Payments
  def initialize(amount:, currency:)
    @amount = amount
    @currency = currency
  end

  def create
    uri = '/api/v1/payments'
    result = SendRequest.request(params, uri: uri)
    if result.status == 200
      JSON.parse(result.body)
    else
      error_body = JSON.parse(result.body)
      raise "Could not create payment with status #{result.status} #{error_body['errors']}"
    end
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
