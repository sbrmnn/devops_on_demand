class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  protected


  include StrongParameterizable

  def after_sign_in_path_for(resource)
    dashboard_path
  end



  private

  def user
    @user ||= current_user
  end
end
