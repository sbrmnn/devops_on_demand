module Users::FreelancersHelper
  def profile_url(freelancer)
    ENV['HOST_URL'] + "/freelancers/#{freelancer.try(:id)}"
  end
end
