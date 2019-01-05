class ImageProcessorClient
  def self.get_profile_image_url(image_path)
    if image_path
      preloaded = Cloudinary::PreloadedFile.new(image_path)
      dim = ProfileImageDimensions.instance
      if preloaded.valid?
        Cloudinary::Utils.cloudinary_url(preloaded.identifier, {height: dim.height, width: dim.width, crop: dim.crop, gravity: dim.gravity})
      else
        nil
      end
    end
  end
end