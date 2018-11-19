class ChatroomPresenter
  attr_reader :chatroom

  def initialize(chatroom)
    @chatroom = chatroom
  end

  def chatroom_id
    chatroom.id
  end

  def participant_names(exclude_user=nil)
    participants(exclude_user).map{|u| "#{u.try(:first_name)} #{u.try(:last_name)}"}.join(', ')
  end

  def participants(exclude_user=nil)
    chatroom.users.where.not(id: exclude_user.try(:id))
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

  private

  def last_message
    GetLatestMessageFromChatroomQuery.call(chatroom)
  end
end