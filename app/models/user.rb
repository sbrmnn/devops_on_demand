class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :generate_unsub_token, if: lambda{ unsub_token.blank? }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  has_one :freelancer

  has_one :payout_identity, through: :freelancer
  has_one :tos_acceptance

  def generate_unsub_token
    self.unsub_token = SecureRandom.hex
  end
end
