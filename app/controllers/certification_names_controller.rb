class CertificationNamesController < ApplicationController

  def index
    render json: CertificationName.all.where(certification_name_params)
  end

  protected

  def certification_name_params
    if !params[:certification_name].is_a? ActionController::Parameters
      {}
    else
      params.require(:certification_name).permit(:provider, :name)
    end
  end
end
