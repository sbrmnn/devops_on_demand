class CreateWorkExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :work_experiences do |t|
      t.string :title, null: false
      t.string :employer
      t.string :achievements
      t.date :from, null: false
      t.date :to
      t.belongs_to :freelancers
      t.timestamps
    end
  end
end
