class FreelancerPresenter < ApplicationPresenter

  def user_name
    "#{model.user_name}"
  end

  def headline
    model.headline || default_headline
  end

  def about_me
    model.about_me || default_about_me
  end

  def rate
    "$#{model.rate}/hr"
  end

  def profile_photo
    ImageProcessorClient.get_profile_image_url(model.profile_photo)
  end

  def skill
    model.skill
  end

  def certifications
    model.certifications
  end

  def work_experiences
    model.work_experiences
  end

  def payout_identity
    model.payout_identity.present? ? model.payout_identity : model.build_payout_identity
  end

  def location
    @location ||= FreelancerPaymentProcessor.adapter.supported_countries[model.location]
  end

  def url
    @url ||= "/freelancers/#{model.id}"
  end

  def missing_payout_fields
    @missing_payout_fields ||= FreelancerPaymentProcessor.new(model).payout_identity_missing_fields
  end

  private

  def user
    @user ||= model.user
  end

  def default_headline
    "Cloud Engineer"
  end

  def default_about_me
    "Summarise your career here. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. You can download this free resume/CV template here. Aenean commodo ligula eget dolor aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget."
  end
end