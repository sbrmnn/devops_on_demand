class ApplicationPresenter
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def self.wrap(collection)
    collection.map do |obj|
       new(obj)
    end
  end
end