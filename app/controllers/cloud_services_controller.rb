class CloudServicesController < ApplicationController
  before_action :get_cloud_services_skills

  def index
    if params[:provider].present?
      @cloud_services = CloudService.all.where(provider: params[:provider]).order(:name).pluck(:id, :name)
    else
      @cloud_services = CloudService.all.order(:name).pluck(:id, :name)
    end
  end


  private


  def get_cloud_services_skills
    if params[:freelancer].present?
      @cloud_services_skills = Skill.where(freelancer: params[:freelancer]).pluck(:cloud_service_id)
    end
  end
end
