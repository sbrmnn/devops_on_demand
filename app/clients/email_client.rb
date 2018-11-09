require 'sendgrid-ruby'
require 'singleton'


class EmailClient
  include Singleton
  attr_reader :vendor

  def initialize
     @vendor = SendGrid::API.new(api_key: ENV['EMAIL_VENDOR_API_KEY'])
  end

  def post(mail_json)
    self.vendor.client.mail._("send").post(request_body: mail_json)
  end
end