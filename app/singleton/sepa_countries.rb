class SepaCountries
  include Singleton
  attr_reader :list

  def initialize
    @list = [:AT, :BE, :DK, :FI, :FR, :DE, :IE, :LU, :NL, :NO, :ES, :SE, :CH, :GB, :IT, :PT]
  end
end