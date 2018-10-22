class CreateFreelancers < ActiveRecord::Migration[5.1]
  def change
    create_table :freelancers do |t|

      t.timestamps
    end
  end
end
