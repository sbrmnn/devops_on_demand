class CreatePayoutIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :payout_identities do |t|
      t.belongs_to  :freelancer
      t.string   "external_account"
      t.datetime "created_at",                                                                                                                                                                                                                                                                                                                                                                                                                       null: false
      t.datetime "updated_at",                                                                                                                                                                                                                                                                                                                                                                                                                       null: false
      t.string   "routing_number"
      t.string   "account_number_last_4"
      t.timestamps
    end
  end
end
