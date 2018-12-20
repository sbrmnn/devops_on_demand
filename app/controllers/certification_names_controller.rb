class CertificationNamesController < ApplicationController

  def index
    render json: CertificationName.all
  end
end
