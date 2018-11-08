require 'sendgrid-ruby'
require 'singleton'
include SendGrid

class EmailClient
  include Singleton
  attr_reader :vendor

  def initialize
     @vendor = SendGrid::API.new(api_key: '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')
  end

  def send_email(recipient, template_id, personalization_hash={})
    mail = Mail.new
    mail.from = Email.new(email: 'webmaster@yumfog.com')
    personalization = Personalization.new
    personalization.add_to(Email.new(email: recipient))
    personalization.add_dynamic_template_data(personalization_hash)
    mail.add_personalization(personalization)
    mail.template_id = template_id
    begin
      EmailClient.instance.send(mail)
    rescue Exception => e
      puts e.message
    end
    self.vendor.client.mail._("send").post(request_body: mail.to_json)
  end
end