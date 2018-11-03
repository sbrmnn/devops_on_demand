class Chatroom < ApplicationRecord
  has_many :chatroom_users
  has_many :users, through: :chatroom_users
  has_many :messages

  def last_message
    messages.last.try(:body)
  end
end
