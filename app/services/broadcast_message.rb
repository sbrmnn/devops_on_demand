class BroadcastMessage
  include Callable

  def initialize(message)
    @message = message
  end

  def call
    ActionCable.server.broadcast "room_channel_#{@message.chatroom_id}", @message.as_json
  end
end