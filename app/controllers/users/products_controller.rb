class Users::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :user



  def index
  end

  def create
    @product = user.products.create(product_params)
  end

  def show
  end

  def update
    @product = user.product
    @product.update_attributes(product_params)
  end

  def destroy
  end

  private

  def product_params
    whitelist_params(params, :product)
  end
end
