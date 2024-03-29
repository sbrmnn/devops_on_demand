class ChatroomUser < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  validates :user, uniqueness: { scope: :chatroom }
end
