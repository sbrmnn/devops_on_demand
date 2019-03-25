class EmailRelayMappersController < ApplicationController
  def show
    from = User.find_by(email: params[:from]).try(:relay_user_name)
    to = User.find_by(relay_user_name: params[:to]).try(:email)
    render json: {from: from, to: to}
  end
end
