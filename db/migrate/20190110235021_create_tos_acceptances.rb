class CreateTosAcceptances < ActiveRecord::Migration[5.1]
  def change
    create_table :tos_acceptances do |t|
      t.belongs_to :user
      t.timestamp :date, null: false
      t.string :ip, null: false
      t.timestamps
    end
  end
end
