class OrderedUserChatroomQuery
  def initialize(curr_user, sort_by= :latest_recipient_message)
    @user = curr_user
    @sort_by = sort_by
  end

  def all
    self.send("by_#{@sort_by}")
  end

  protected

  def by_id
    user_chatrooms.order(:id)
  end

  def by_latest_recipient_message
    #TODO
    # user_chatrooms
  end

  private

  def user_chatrooms
    @user.chatrooms
  end


end