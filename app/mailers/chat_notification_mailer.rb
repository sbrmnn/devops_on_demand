class ChatNotificationMailer < ApplicationMailer
  default from: "YumFog LLC <webmaster@yumfog.com>"
  def send_email(user, sender_name, chatroom_id, chat_text )
    @name = user.first_name
    @user_id = user.id
    @room = "chatroom_#{chatroom_id}"
    @chat_sender_name = sender_name
    @chat_text = chat_text
    @email = user.email
    @unsub_token = user.unsub_token
    @Sender_Name = "YumFog LLC"
    @Sender_Address = "75 5th St NW"
    @Sender_City = "Atlanta"
    @Sender_State = "Ga"
    @Sender_Zip = "30308"
    mail(to: @email, subject: "You\'ve received a new message from #{@chat_sender_name}")
  end
end
