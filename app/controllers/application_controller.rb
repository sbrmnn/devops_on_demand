class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name ,:email, :password, :password_confirmation])
  end

  private

  def set_user
    cookies[:current_user_id] = current_user.try(:id) || nil
  end

  def set_chatroom
    @chatroom = current_user.chatrooms.find_by(id: params[:chatroom_id])
    if @chatroom.blank?
      respond_to do |format|
        format.html do
          flash[:error] = 'Access denied'
          redirect_to root_url
        end
        format.json do
          render json: {}, status: 401
        end
      end
    end
  end
end
