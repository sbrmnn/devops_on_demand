class CreateCertifications < ActiveRecord::Migration[5.1]
  def change
    create_table :certifications do |t|

      t.timestamps
    end
  end
end
