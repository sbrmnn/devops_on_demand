class OrderedUserChatroomQuery
  def initialize(curr_user, sort_by= :latest_recipient_message)
    @user = curr_user
    @sort_by = sort_by

  end

  def all
    self.send("by_#{@sort_by}")
  end

  protected

  def by_latest_recipient_message
    # TODO make a join statement in the future.
    chatroom_ids = @user.chatrooms.pluck(:id)
    chatroom_id_ordered = Message.where(:chatroom_id => [chatroom_ids]).where.not(user: @user).order("created_at DESC").pluck(:chatroom_id).uniq
    Chatroom.find([chatroom_id_ordered])
  end




end