class CertificationNames
  include Singleton
  attr_reader :certifications

  def initialize
    @certifications = CertificationName.all.pluck(:name, :provider, :id).group_by { |c| c[1] }
  end
end



