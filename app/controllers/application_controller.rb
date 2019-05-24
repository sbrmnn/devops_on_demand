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
