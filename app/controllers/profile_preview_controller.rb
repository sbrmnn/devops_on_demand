class ProfilePreviewController < ApplicationController
  layout 'profile'

  def index
     freelancer = Freelancer.new(freelancer_params)
     freelancer.user_id = current_user.id
     @profile_preview =  ProfilePreviewPresenter.new(freelancer)
  end

  def freelancer_params
    params.require(:freelancer).permit(:headline, :about_me, :rate, :profile_photo, skill_attributes: [:types], certifications_attributes: [:id, :certification_name_id, :vendor_identifier], work_experiences_attributes: [:id, :title, :employer, :from, :to, :achievements])
  end
end
