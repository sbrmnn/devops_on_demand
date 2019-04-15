class CloudServicesController < ApplicationController
  def index
    if params[:provider].present?
      @cloud_services = CloudService.all.where(provider: params[:provider]).order(:name).pluck(:id, :name)

    else
      @cloud_services = CloudService.all.order(:name).pluck(:id, :name)
    end
  end
end
