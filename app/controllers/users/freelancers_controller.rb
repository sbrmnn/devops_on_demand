class Users::FreelancersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    current_user.build_freelancer(freelancer_params).save
    redirect_to current_user
  end

  def show
  end

  def update
    current_user.freelancer.update_attributes(freelancer_params)
    redirect_to current_user
  end

  def destroy
  end

  private

  def freelancer_params
    params.require(:freelancer).permit(:headline, :about_me, :rate, :profile_photo, skill_attributes: [:types], certifications_attributes: [:id, :certification_name_id, :vendor_identifier], work_experiences_attributes: [:id, :title, :employer, :from, :to, :achievements])
  end
end
