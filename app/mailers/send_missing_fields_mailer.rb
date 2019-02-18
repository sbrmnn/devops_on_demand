class SendMissingFieldsMailer < ApplicationMailer
  def send
    mail(to: @email, subject: "You\'ve received a new message from #{@chat_sender_name}")
  end
end
