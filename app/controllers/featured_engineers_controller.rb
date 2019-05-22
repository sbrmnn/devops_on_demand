class FeaturedEngineersController < ApplicationController
  def index
    @freelancers = Freelancer.all
  end
end
