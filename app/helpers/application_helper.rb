module ApplicationHelper

  def present(model, presenter_class=nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model)
    yield(presenter) if block_given?
  end

  def stripe_countries
    @stripe_countries ||=[
        {country: 'United States', code: 'US'},
        {country: 'Australia', code: 'AU'},
        {country: 'Austria', code: 'AT'},
        {country: 'Belgium', code: 'BE'},
        {country: 'Brazil ', code: 'BR'},
        {country: 'Canada', code: 'CA'},
        {country: 'Denmark', code: 'DK'},
        {country: 'Finland', code: 'FI'},
        {country: 'France', code: 'FR'},
        {country: 'Germany', code: 'DE'},
        {country: 'Hong Kong', code: 'HK'},
        {country: 'Ireland', code: 'IE'},
        {country: 'Japan', code: 'JP'},
        {country: 'Luxembourg', code: 'LU'},
        {country: 'Mexico ', code: 'MX'},
        {country: 'Netherlands', code: 'NL'},
        {country: 'New Zealand', code: 'NZ'},
        {country: 'Norway', code: 'NO'},
        {country: 'Singapore', code: 'SG'},
        {country: 'Spain', code: 'ES'},
        {country: 'Sweden', code: 'SE'},
        {country: 'Switzerland', code: 'CH'},
        {country: 'United Kingdom', code: 'GB'},
        {country: 'Italy', code: 'IT'},
        {country: 'Portugal', code: 'PT'}
    ].map{|c| OpenStruct.new c}
  end

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
  
  def chatroom_recipients(chatroom)
    ChatroomPresenter.new(chatroom).participant_names_excluding_user(current_user)
  end

  def new_message_for_user?(chatroom)
    ChatroomPresenter.new(chatroom).new_message_for_user?(current_user)
  end
end


