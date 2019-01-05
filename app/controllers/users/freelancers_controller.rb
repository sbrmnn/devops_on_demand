class Users::FreelancersController < ApplicationController
  before_action :authenticate_user!
  include StrongParameterizable
  before_action :get_image_id, only: [:create, :update]

  def index
  end

  def create
    @freelancer = current_user.build_freelancer(freelancer_params)
    @freelancer.save
  end

  def show
  end

  def update
    @freelancer = current_user.freelancer
    @freelancer.update_attributes(freelancer_params)
  end

  def destroy
  end

  private

  def freelancer_params
    whitelist_params(params, :freelancer)
  end

  def get_image_id
    if freelancer_params[:profile_photo].present?
      freelancer_params[:profile_photo] = GetImageIdFromImageProcessor.call(freelancer_params[:profile_photo])
    end
  end
end
