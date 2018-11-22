class CreateCertifications < ActiveRecord::Migration[5.1]
  def change
    create_table :certifications do |t|
      t.string :provider
      t.string :name
      t.belongs_to :freelancers
      t.timestamps
    end
  end
end
