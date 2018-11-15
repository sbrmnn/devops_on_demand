module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'notice'
        'alert-info'
      else
        nil
    end
  end

  def render_navbar_and_footer?
    !controller.is_a?(Devise::SessionsController) &&  !controller.is_a?(Devise::RegistrationsController) &&  !controller.is_a?(SubscriptionSettingsController)
  end

  def render_submenu?
    controller.is_a?(UsersController)
  end

  def chatroom_recipients(chatroom)
    ChatroomPresenter.new(chatroom).participant_names(current_user)
  end

  def new_message_for_user?(chatroom)
    ChatroomPresenter.new(chatroom).new_message_for_user?(current_user)
  end



end


