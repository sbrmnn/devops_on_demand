class RemoveColumnProviderFromCertifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :certifications, :provider, :string
  end
end
