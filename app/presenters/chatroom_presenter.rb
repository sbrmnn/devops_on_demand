class ChatroomPresenter < ApplicationPresenter

  def chatroom_id
    model.id
  end

  def participant_names_excluding_user(exclude_user=nil)
    participants_excluding_user(exclude_user).map{|u| "#{u.try(:first_name)} #{u.try(:last_name)}" }.join(', ')
  end

  def participants_excluding_user(exclude_user=nil)
    participants(exclude_user)
  end

  def latest_message_type_for_user(curr_user)
    if last_message.present? && (last_message.user_id != curr_user.id)
      'new_msg'
    elsif last_message.present?
      'my_msg'
    else
      'no_msg'
    end
  end

  def last_message
    GetLatestMessageFromChatroomQuery.call(model)
  end

  private

  def participants(exclude_user=nil)
    model.users.where.not(id: exclude_user.try(:id))
  end
end
