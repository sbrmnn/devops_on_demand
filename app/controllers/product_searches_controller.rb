class ProductSearchesController < ApplicationController


  def index
    @product_searches = Product.search(query, where: where_hash, operator: :or, misspellings: {edit_distance: 3}, match: :word )
  end

  private

  def query
    product_searches[:value].present? ? product_searches[:value] : "*"
  end

  def where_hash
    h = {}
    if product_searches[:cloud_service_array].present?
      h[:cloud_services_ids] = product_searches[:cloud_service_array]
    end
    h
  end

  def product_searches
    whitelist_params(params, :product_searches)
  end
end
