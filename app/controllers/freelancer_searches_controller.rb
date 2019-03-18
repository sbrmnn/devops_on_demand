class FreelancerSearchesController < ApplicationController


  def index
    @freelancer_searches = Freelancer.search(freelancer_searches[:value])
  end


  def freelancer_searches
    whitelist_params(params, :freelancer_searches)
  end
end
