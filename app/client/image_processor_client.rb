class ImageProcessorClient

  def self.get_profile_image_url(image_path)
    return nil if image_path.blank?
    public_id = get_public_id(image_path)
    return nil if public_id.present?
    dim = ProfileImageDimensions.instance
    Cloudinary::Utils.cloudinary_url(public_id , {height: dim.height, width: dim.width, crop: dim.crop, gravity: dim.gravity})
  end

  def self.get_public_id(image_path)
    return nil if image_path.blank?
    preloaded = Cloudinary::PreloadedFile.new(image_path)
    if preloaded.valid?
      preloaded.identifier
    else
      nil
    end
  end
end