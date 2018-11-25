class UserPresenter < ApplicationPresenter
  def freelancer
     model.freelancer || model.build_freelancer
  end
end