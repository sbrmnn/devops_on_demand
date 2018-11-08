module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'alert'
        'alert-danger'
      when 'notice'
        'alert-info'
      else
        flash_type.to_s
    end
  end

  def render_navbar_and_footer?
    !controller.is_a?(Devise::SessionsController) &&  !controller.is_a?(Devise::RegistrationsController) &&  !controller.is_a?(SubscriptionSettingsController)
  end

  def chatroom_info(chatroom, current_user)
    ChatroomDecorator.new(chatroom, current_user)
  end

  def get_chatrooms_with_latest_messages(current_user)
    chatrooms = current_user.chatrooms
    ChatroomWithLatestUnreadMessagesQuery.call(chatrooms)
  end

  def new_message?(chatroom, current_user)
    chatroom_info(chatroom, current_user).new_message?
  end
end


