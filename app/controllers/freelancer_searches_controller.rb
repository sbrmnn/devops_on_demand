class FreelancerSearchesController < ApplicationController
  include StrongParameterizable

  def index
    render json: Freelancer.search(freelancer_searches[:value])
  end


  def freelancer_searches
    whitelist_params(params, :freelancer_searches)
  end
end
