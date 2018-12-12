class FromToChangeColumnTypeInWorkexperiences < ActiveRecord::Migration[5.1]
  def up
    change_column :work_experiences, :from, :string
    change_column :work_experiences, :to, :string
  end

  def down
    change_column :work_experiences, :from, :date
    change_column :work_experiences, :to,   :date
  end
end
