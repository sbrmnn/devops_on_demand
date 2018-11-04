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
    Chatroom.joins(:messages)
            .where("messages.user_id = ?", @user.id)
            .order("messages.created_at DESC").uniq
  end
end