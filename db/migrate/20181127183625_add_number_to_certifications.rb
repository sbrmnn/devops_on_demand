class AddNumberToCertifications < ActiveRecord::Migration[5.1]
  def change
    add_column :certifications, :number, :integer
  end
end
