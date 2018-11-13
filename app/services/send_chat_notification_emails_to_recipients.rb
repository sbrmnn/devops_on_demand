require 'sendgrid-ruby'

class SendChatNotificationEmailsToRecipients
  include SendGrid

  def initialize(template_id='d-922a172bd405417c97d73ddc1e798a05')
    @template_id = template_id
    @from = 'webmaster@yumfog.com'
    @from_name = "YumFog"
    @from_address = "75 5th St Nw"
    @from_city = "Atlanta"
    @from_state = "Georgia"
    @from_zip  = 30308
    @earliest_message_created_at_date = (ENV['CHAT_EMAIL_INTERVAL_IN_MINUTES'].to_i + 5).minutes.ago
  end

  def call
    Chatroom.all.each do |cr|
      last_message = cr.messages.where("created_at > ?",  @earliest_message_created_at_date).last
      next if last_message.blank?
      notification_sent = last_message.try(:notification_sent)
      next if notification_sent.present?
      last_msg_user = last_message.user
      email_recipients = cr.users.where.not(id: last_msg_user.id).where(chat_notification_subscription: true)
      email_recipients.each do |er|
        begin
          ChatNotificationMailer.send_email(er, last_msg_user.first_name, cr.id, last_message.body ).deliver
          last_message.update_attribute(:notification_sent, true)
        rescue Exception => e
          Rails.logger.error "Email Error: SendChatNotificationEmailsToRecipients #{e.message}"
        end
      end
    end
  end
end
