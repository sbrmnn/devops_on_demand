class GetImageIdFromImageProcessor
  attr_reader :url
  include Callable

  def initialize(url)
    @url = url
  end

  def call
    if url
      preloaded = Cloudinary::PreloadedFile.new(url)
      preloaded.identifier if preloaded.valid?
    end
  end
end