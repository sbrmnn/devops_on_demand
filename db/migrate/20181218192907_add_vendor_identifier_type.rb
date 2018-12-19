class AddVendorIdentifierType < ActiveRecord::Migration[5.1]
  def change
    add_column :certifications, :vendor_identifier, :string
  end
end
