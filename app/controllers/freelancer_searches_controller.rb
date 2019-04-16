class FreelancerSearchesController < ApplicationController


  def index
    @freelancer_searches = Freelancer.search(freelancer_searches[:value], includes: [:cloud_services,:certification_names, :work_experiences] )
  end


  def freelancer_searches
    whitelist_params(params, :freelancer_searches)
  end
end
