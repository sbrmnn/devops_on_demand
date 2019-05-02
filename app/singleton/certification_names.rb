class CertificationNames
  include Singleton
  attr_reader :certifications

  def initialize
    @certifications = CertificationName.all.map{|l| [l.name, l.provider, l.id]}.group_by { |c| c[1] }
  end
end



