class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :generate_unsub_token, if: lambda{ unsub_token.blank? }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  has_many :jobs
  has_one :setting
  has_one :freelancer
  has_one :credit_card

  has_one :payout_identity, through: :freelancer
  has_one :tos_acceptance

  before_save :configure_settings
  before_save :generate_relay_user_name
  before_save :downcase_email

  auto_strip_attributes :first_name, :last_name, :email

  def generate_unsub_token
    self.unsub_token = SecureRandom.hex
  end

  private

  def downcase_email
    self.email = self.email.downcase
  end

  def generate_relay_user_name
    if relay_user_name.blank?
      self.relay_user_name = "#{first_name}#{SecureRandom.hex(2)}@mail.yumfog.com".downcase
      while User.exists?(relay_user_name: relay_user_name)
        self.relay_user_name = "#{first_name}#{SecureRandom.hex(2)}@mail.yumfog.com".downcase
      end
    end
  end

  def configure_settings
    if self.setting.blank?
      self.setting = Setting.new
    end
  end
end
