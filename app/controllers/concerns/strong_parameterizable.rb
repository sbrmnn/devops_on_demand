module StrongParameterizable
  include ActiveSupport::Concern

  private

  def whitelist_params(params, controller_name, preview=false)
    raise "controller name arguement must be a symbol" unless controller_name.is_a? Symbol
    params.require(controller_name).permit(permitted_params(controller_name, preview))
  end


  def permitted_params(controller_name, preview)
    {
        freelancer: [:headline, :about_me, :rate, :location ,:profile_photo,  skill_attributes: [:types],
                     certifications_attributes:   whitelist_certifications_attributes(preview),
                     work_experiences_attributes: whitelist_work_experiences_attributes(preview)],
        freelancer_searches: [:value]
    }[controller_name]
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