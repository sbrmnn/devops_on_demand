class ChatNotificationMailer < ApplicationMailer
  default from: "YumFog LLC <webmaster@yumfog.com>"
  def send_email(user, sender_name, chatroom_id, chat_text)
    set_template_variables(user, sender_name, chatroom_id, chat_text)
    mail(to: @email, subject: "You\'ve received a new message from #{@chat_sender_name}")
  end

  private

  def set_template_variables(user, sender_name, chatroom_id, chat_text)
    @name = user.first_name
    @user_id = user.id
    @room = "chatroom_#{chatroom_id}"
    @chat_sender_name = sender_name
    @chat_text = chat_text
    @email = user.email
    @unsub_token = user.unsub_token
    @platform_name = "YumFog LLC"
    @platform_address = "75 5th St NW"
    @platform_city = "Atlanta"
    @platform_state = "Ga"
    @platform_zip = "30308"
  end
end
