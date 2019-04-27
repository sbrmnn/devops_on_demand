class MissingFieldsPayoutIdentityChannel < ApplicationCable::Channel
  def subscribed
    if user_can_access?
      room_name = "missing_fields_payout_identity_#{params[:freelancer_id]}"
      stream_from room_name
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.broadcast(data, freelancer_id)
     ActionCable.server.broadcast "missing_fields_payout_identity_#{freelancer_id}", data.as_json
  end

  private

  def user_can_access?

    if current_user.freelancer.blank?
      false
    else
      current_user.freelancer.id == params[:freelancer_id].try(:to_i)
    end
   end
end
