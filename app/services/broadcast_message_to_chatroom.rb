class BroadcastMessageToChatroom
  include Callable

  def initialize(chatroom, message)
    @chatroom = chatroom
    @message = message
  end

  def call
    ActionCable.server.broadcast "room_channel_#{@chatroom.id}", @message.as_json
  end
end