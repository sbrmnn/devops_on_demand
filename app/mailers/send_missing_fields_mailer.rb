class SendMissingFieldsMailer < ApplicationMailer
  default from: "YumFog LLC <webmaster@yumfog.com>"

  def send_to_product(product)
    @user = product.user
    @product_name = @user.first_name
    @host = ENV['HOST_URL']
    mail(to: @user.email, subject: "We need more information from you.")
  end
end
