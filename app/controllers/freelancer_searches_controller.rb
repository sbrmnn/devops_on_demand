class FreelancerSearchesController < ApplicationController


  def index
    @product_searches = Product.search(query, where: where_hash, operator: :or, misspellings: {edit_distance: 3}, match: :word )
  end

  private

  def query
    freelancer_searches[:value].present? ? freelancer_searches[:value] : "*"
  end

  def where_hash
    h = {}
    if freelancer_searches[:cloud_service_array].present?
      h[:cloud_services_ids] = freelancer_searches[:cloud_service_array]
    end
    h
  end

  def freelancer_searches
    whitelist_params(params, :freelancer_searches)
  end
end
