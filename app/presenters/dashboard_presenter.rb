class DashboardPresenter < ApplicationPresenter
  module Product

  end

  module Job
    def poster
      "#{model.user.first_name} #{model.user.last_name}"
    end

    def poster_email
      UserPresenter.new(model.user).relay_user_name
    end

    def acceptance
      model.acceptance
    end

    def from
      model.from
    end

    def to
      model.to
    end

    def hours
      model.hours
    end

    def total
      '%.2f' % (model.total/100.0)
    end

    def description
      model.description
    end

    def id
      model.id
    end


    def product
      model.product
    end
  end

  module Chatroom
    def chatroom_id
      model.id
    end

    def participants_excluding_user(exclude_user=nil)
      participants(exclude_user)
    end

    def latest_message_type_for_user(curr_user)
      lst_msg = last_message
      if lst_msg.present? && (lst_msg.user_id != curr_user.id)
        'new_msg'
      elsif lst_msg.present?
        'my_msg'
      else
        'no_msg'
      end
    end

    def last_message
      @last_message ||= GetLatestMessageFromChatroomQuery.call(model)
    end

    private

    def participants(exclude_user=nil)
      model.users.where.not(id: exclude_user.try(:id)).first
    end
  end

  module Product
    def user_name
      "#{model.user_name}"
    end

    def headline
      model.headline || default_headline
    end

    def about_me
      model.about_me || default_about_me
    end

    def user
      @user ||= model.user
    end

    def rate
      "#{model.platform_rate}"
    end

    def location
      @location ||= model.location.to_sym
    end

    def full_name_location
      ProductPaymentProcessor.adapter.supported_countries[location.to_sym]
    end

    def photo
      model.photo
    end

    def image_public_id
      model&.photo&.split("/")&.last&.split(".")&.first
    end

    def skill
      model.skill&.types&.split(',')&.first(8)
    end

    def certification_names
      model.certification_names
    end

    def work_experiences
      model.work_experiences
    end

    def skills
      model.skills
    end

    def cloud_services
      model.cloud_services
    end

    def european?
      SepaCountries.instance.list.include?(location)
    end

    def american?
      location == :US
    end

    def canadian?
      location == :CA
    end

    def australian?
      location == :AU
    end

    def settlement_currency
      ProductPaymentProcessor.new(model).settlement_currency
    end

    def source_control_url
      model.source_control_url
    end

    def payout_identity
      model.payout_identity.present? ? model.payout_identity : model.build_payout_identity
    end

    def url
      @url ||= "/products/#{model.id}"
    end

    def missing_payout_fields
      @missing_payout_fields ||= ProductPaymentProcessor.new(model).payout_identity_missing_fields
    end

    private


    def default_headline
      "Cloud Engineer"
    end

    def default_about_me
      "Summarise your career here. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. You can download this free resume/CV template here. Aenean commodo ligula eget dolor aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget."
    end
  end
end