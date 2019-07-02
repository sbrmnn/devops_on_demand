class FeaturedEngineersController < ApplicationController
  def index
    @products = Product.all
  end
end
