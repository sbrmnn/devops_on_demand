class CloudServices
  include Singleton
  attr_reader :services

  def initialize
    @services = CloudService.all.order(:name).pluck(:id, :name, :provider).group_by { |c| c[2] }
  end
end