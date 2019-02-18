class WebhooksController < ApplicationController
  def create
    event_json = JSON.parse(request.body.read)
    render event_json
  end
end
