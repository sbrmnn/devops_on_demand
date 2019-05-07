class FreelancerSearchesController < ApplicationController


  def index
    @freelancer_searches = Freelancer.search(query, where: where_hash , includes: [:cloud_services, :certification_names, :work_experiences], operator: :or, misspellings: {edit_distance: 3}, match: :word )
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
