class UserPresenter < ApplicationPresenter

  def freelancer
     model.freelancer || model.build_freelancer
  end

  def full_name
    "#{model.first_name} #{model.last_name}"
  end
end