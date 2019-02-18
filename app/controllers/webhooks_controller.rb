class WebhooksController < ApplicationController
  protect_from_forgery :except => :create
  
  def create
    event_json = JSON.parse(request.body.read)
    render json: event_json
  end
end
