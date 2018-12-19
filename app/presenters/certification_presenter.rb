class CertificationPresenter < ApplicationPresenter
  def vendor_identifier
    "#{model.try(:vendor_identifier)}"
  end

  def provider
     model.try(:certification_name).try(:provider)
  end

  def name
    model.try(:certification_name).try(:name)
  end
end