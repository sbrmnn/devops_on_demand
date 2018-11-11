class Message < ApplicationRecord
  before_save :escape_body
  belongs_to  :chatroom
  belongs_to  :user
  validates_presence_of :user


  protected

  def escape_body
    self.body = ERB::Util.html_escape(body)
  end
end
