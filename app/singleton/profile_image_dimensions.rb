class ProfileImageDimensions
  include Singleton
  attr_reader :height, :width, :crop, :gravity

  def initialize
    @height = 250
    @width  = 250
    @crop = :crop
    @gravity = :face
  end
end