class ChatroomPresenter < ApplicationPresenter

  def chatroom_id
    model.id
  end

  def participants_excluding_user(exclude_user=nil)
    participants(exclude_user)
  end

  def latest_message_type_for_user(curr_user)
    lst_msg = last_message
    if lst_msg.present? && (lst_msg.user_id != curr_user.id)
      'new_msg'
    elsif lst_msg.present?
      'my_msg'
    else
      'no_msg'
    end
  end

  def last_message
    @last_message ||= GetLatestMessageFromChatroomQuery.call(model)
  end

  private

  def participants(exclude_user=nil)
    model.users.where.not(id: exclude_user.try(:id)).first
  end
end
