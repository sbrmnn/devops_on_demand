module StrongParameterizable
  include ActiveSupport::Concern

  private

  def whitelist_params(params, controller_name, preview=false)
    raise "controller name arguement must be a symbol" unless controller_name.is_a? Symbol
    params.require(controller_name).permit(permitted_params(controller_name, preview))
  end


  def permitted_params(controller_name, preview)
    {
        freelancer: [:headline, :about_me, :source_control_url ,:rate, :location ,:profile_photo,  skill_attributes: [:types],
                     certifications_attributes:   whitelist_certifications_attributes(preview),
                     work_experiences_attributes: whitelist_work_experiences_attributes(preview),
                     cloud_services: []],
        freelancer_searches: [:value],
        credit_card: [:front_end_token, :name, :line1, :line2, :city, :state, :zip, :country],
        payout_identity: [:external_account, :account_name, :account_type, legal_entity_attributes: legal_entity_attributes],
        setting: [:newsletter_subscription, :chat_notification_subscription],
        chatrooms: [:freelancer_user],
        job: [:freelancer_id, :description, :hours, :from, :total, :front_end_token, :name, :line1, :line2, :city, :state, :zip, :country],
        job_approvals: [:acceptance]

    }[controller_name]
  end

  def legal_entity_attributes
    [:id ,:entity_type, :first_name, :last_name, :dob_month, :dob_day, :dob_year, :ssn_last_4, :personal_id_number, :business_name, :business_tax_id, :address_line1, :address_city, :address_state, :address_postal_code, :address_country, :verification_image]
  end

  def whitelist_work_experiences_attributes(preview)
    if preview
      [:title, :employer, :from, :to, :achievements]
    else
      [:id, :title, :employer, :from, :to, :achievements]
    end
  end

  def whitelist_certifications_attributes(preview)
    if preview
      [:certification_name_id, :vendor_identifier]
    else
      [:id, :certification_name_id, :vendor_identifier]
    end
  end
end