class RemoveColumnNameFromCertifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :certifications, :name, :string
  end
end
