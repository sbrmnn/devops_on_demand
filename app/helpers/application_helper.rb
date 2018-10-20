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

  def login_or_registration_page?
    controller.is_a?(Devise::SessionsController) || controller.is_a?(Devise::RegistrationsController)
  end
end


