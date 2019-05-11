class ChangeMerchantIdToChargeIdentifierInTransactions < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :merchant_id, :charge_identifier
  end
end
