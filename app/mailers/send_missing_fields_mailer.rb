class SendMissingFieldsMailer < ApplicationMailer
  default from: "YumFog LLC <webmaster@yumfog.com>"

  def send_to_freelancer(freelancer)
    @user = freelancer.user
    @freelancer_name = @user.first_name
    mail(to: @user.email, subject: "We need more information from you.")
  end
end
