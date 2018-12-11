class UserBuilder
  attr_reader :user

  def self.build
    builder = new
    yield(builder)
    builder.user
  end

  def initialize
    @user = User.new
  end

  def set_freelancer
    @user.freelancer || @user.build_freelancer
  end

  def set_skills

  end

  def set_headline(headline)
    @user.headline = headline
  end

  def set_about_me(about_me)
    @user.about_me = about_me
  end

  def set_rate(rate)
    @user.rate = rate
  end

  def set_profile_photo(url)
    @user.profile_photo = url
  end
end