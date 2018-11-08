class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :generate_unsub_token, if: lambda{ unsub_token.blank? }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  def generate_unsub_token
    self.unsub_token = SecureRandom.hex
  end
end
