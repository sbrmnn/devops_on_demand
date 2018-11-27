class AddColumnCertificationNameIdToCertification < ActiveRecord::Migration[5.1]
  def change
    add_column :certifications, :certification_name_id, :integer
    add_index :certifications, :certification_name_id
  end
end
