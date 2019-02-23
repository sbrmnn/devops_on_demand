class CreateMissingPayoutFields < ActiveRecord::Migration[5.1]
  def change
    create_table :missing_payout_fields do |t|
      t.belongs_to :payout_identity
      t.string :field
      t.timestamps
    end
  end
end
