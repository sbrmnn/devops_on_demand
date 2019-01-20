class AddMerchantIdToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :merchant_id, :string
  end
end
