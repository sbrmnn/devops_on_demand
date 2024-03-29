class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :generate_unsub_token, if: lambda{ unsub_token.blank? }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  attr_accessor :terms_of_service

  has_many :chatroom_users, dependent: :destroy
  has_many :chatrooms, through: :chatroom_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_one :setting, dependent: :destroy
  has_one :freelancer, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_one :payout_identity, through: :freelancer, dependent: :destroy
  has_one :tos_acceptance, dependent: :destroy

  validates_presence_of :first_name, :last_name
  validates :terms_of_service, acceptance: true, on: :create

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
      self.relay_user_name = "#{first_name}#{SecureRandom.hex(2)}@relay.yumfog.com".downcase
      while User.exists?(relay_user_name: relay_user_name)
        self.relay_user_name = "#{first_name}#{SecureRandom.hex(2)}@relay.yumfog.com".downcase
      end
    end
  end

  def configure_settings
    if self.setting.blank?
      self.setting = Setting.new
    end
  end
end
