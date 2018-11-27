class CreateCertificationNames < ActiveRecord::Migration[5.1]
  def change
    create_table :certification_names do |t|
      t.string :provider
      t.string :name
      t.timestamps
    end
  end
end
