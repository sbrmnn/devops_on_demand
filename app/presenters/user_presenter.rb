class UserPresenter < ApplicationPresenter

  def freelancer
     build_freelancer_obj
  end

  def full_name
    "#{model.first_name} #{model.last_name}"
  end

  def payout_identity
    freelancer.payout_identity
  end

  def enabled_fields
    []
  end

  private

  def build_freelancer_obj
    freelancer = model.freelancer || model.build_freelancer
    freelancer.payout_identity.present? ||  freelancer.build_payout_identity
    freelancer.work_experiences.present? ||  freelancer.work_experiences.build
    freelancer.skill.present? ||  freelancer.build_skill
    freelancer.certifications.present? ||  freelancer.certifications.build
    freelancer
  end
end



