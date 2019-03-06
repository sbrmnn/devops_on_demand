class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :generate_unsub_token, if: lambda{ unsub_token.blank? }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  has_one :setting
  has_one :freelancer
  has_one :credit_card

  has_one :payout_identity, through: :freelancer
  has_one :tos_acceptance

  before_save :configure_settings

  def generate_unsub_token
    self.unsub_token = SecureRandom.hex
  end

  private

  def configure_settings
    if self.setting.blank?
      self.setting = Setting.new
    end
  end
end
