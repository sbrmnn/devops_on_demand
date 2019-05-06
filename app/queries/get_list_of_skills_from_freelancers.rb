class GetListOfSkillsFromFreelancers
  def self.call
    CloudService.joins(:skills).group("cloud_services.id").having('count(skills) > 0').pluck(:id, :name, :provider).group_by { |c| c[2] }
  end
end