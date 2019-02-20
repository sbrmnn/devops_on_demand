class MissingFieldsPayoutIdentityChannel < ApplicationCable::Channel
  def subscribed
    room_name = "missing_fields_payout_identity_#{params[:freelancer_id]}"
    stream_from room_name
    reject unless user_can_access?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.broadcast(data, freelancer_id)
     ActionCable.server.broadcast "missing_fields_payout_identity_#{freelancer_id}", data.as_json
  end

  private

  def user_can_access?
    current_user.freelancer.id == params[:freelancer_id].try(:to_i)
  end
end
