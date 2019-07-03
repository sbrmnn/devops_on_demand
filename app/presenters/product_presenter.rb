class ProductPresenter < ApplicationPresenter
  def image_public_id
    model&.photo&.split("/")&.last&.split(".")&.first
  end

  def self.featured
    wrap(Product.all)
  end

  def description(truncate=false)
    if truncate
      model.description&.truncate(54)
    else
      model.description
    end
  end

  def platform_cost
    model.platform_cost
  end

  def headline
    model.headline
  end

  def user
    @user ||= model.user
  end

  def creator
    @creator ||= user.first_name
  end

  def tags
    model.tags.pluck(:name)
  end
end