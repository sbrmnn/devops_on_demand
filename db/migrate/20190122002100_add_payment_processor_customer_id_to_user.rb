class AddPaymentProcessorCustomerIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :payment_processor_customer_id, :string
  end
end
