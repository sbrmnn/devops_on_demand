class RemoveNumberFromCertifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :certifications, :number, :integer
  end
end
