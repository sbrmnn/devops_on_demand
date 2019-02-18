class ChatNotificationMailer < ApplicationMailer
  default from: "YumFog LLC <webmaster@yumfog.com>"

  def send(message, user)
    set_template_variables(message, user)
    mail(to: @email, subject: "You\'ve received a new message from #{@chat_sender_name}")
  end

  private

  def set_template_variables(message, user)
    chatroom_id =  message.chatroom.id
    chat_text = message.body
    sender_name = message.user.first_name
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
