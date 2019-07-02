module Users::ProductsHelper
  def profile_url(product)
    ENV['HOST_URL'] + "/products/#{product.try(:id)}"
  end
end
