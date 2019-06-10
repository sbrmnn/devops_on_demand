class ProductPresenter < ApplicationPresenter
  def image_public_id
    model&.photo&.split("/")&.last&.split(".")&.first
  end
end