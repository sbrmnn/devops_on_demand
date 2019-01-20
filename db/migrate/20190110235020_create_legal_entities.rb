class CreateLegalEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :legal_entities do |t|
      t.belongs_to :payout_identifier
      t.integer :dob_day
      t.integer :dob_year
      t.integer :dob_month
      t.string  :type
      t.string  :address_city
      t.string  :address_line1
      t.string  :address_state
      t.string  :address_country
      t.string  :address_postal_code
      t.string  :last_name
      t.string  :first_name
      t.string  :ssn_last_4
      t.string  :verification_document
      t.string  :business_name
      t.string  :business_tax_id
      t.string  :personal_address_city
      t.string  :personal_address_line1
      t.string  :personal_address_postal_code
      t.string  :personal_id_number
      t.timestamps
    end
  end
end
