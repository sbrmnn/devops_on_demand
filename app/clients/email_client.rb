require 'sendgrid-ruby'
require 'singleton'
include SendGrid

class EmailClient
  include Singleton
  attr_reader :vendor

  def initialize
     @vendor = SendGrid::API.new(api_key: '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')
     @mail = Mail.new
  end

  def send_chat_notification(recipient_email, personalization_hash={})
    template_id = 'd-922a172bd405417c97d73ddc1e798a05'
    @mail.from = Email.new(email: 'webmaster@yumfog.com')
    personalization = Personalization.new
    personalization.add_to(Email.new(email: recipient_email))
    personalization.add_dynamic_template_data(personalization_hash)
    @mail.add_personalization(personalization)
    @mail.template_id = template_id
    begin
      self.vendor.client.mail._("send").post(request_body: @mail.to_json)
    rescue Exception => e
      Rails.logger.error "Email Error: send_chat_notification #{e.message}"
    end
  end

  def send_newsletter
  end
end