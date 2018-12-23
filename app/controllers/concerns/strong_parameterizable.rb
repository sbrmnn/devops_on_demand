module StrongParameterizable
  include ActiveSupport::Concern

  private

  def whitelist_params(params, controller_name)
    raise "controller name arguement must be a symbol" unless controller_name.is_a? Symbol
    params.require(controller_name).permit(permitted_params(controller_name))
  end


  def permitted_params(controller_name)
    {
        freelancer: [:headline, :about_me, :rate, :location ,:profile_photo,  skill_attributes: [:types],
                     certifications_attributes: [:id, :certification_name_id, :vendor_identifier],
                     work_experiences_attributes: [:id, :title, :employer, :from, :to, :achievements]]
    }[controller_name]
  end

end