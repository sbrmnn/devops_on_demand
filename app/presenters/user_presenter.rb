class UserPresenter < ApplicationPresenter

  def freelancer
    @freelancer ||= build_freelancer_obj
  end

  def full_name
    "#{model.first_name} #{model.last_name}"
  end


  private

  def build_freelancer_obj
    freelancer = model.freelancer || model.build_freelancer
    freelancer.work_experiences.present? ||  freelancer.work_experiences.build
    freelancer.skill.present? ||  freelancer.build_skill
    freelancer.certifications.present? ||  freelancer.certifications.build
    freelancer
  end
end



