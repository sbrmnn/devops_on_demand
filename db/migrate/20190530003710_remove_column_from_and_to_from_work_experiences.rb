class RemoveColumnFromAndToFromWorkExperiences < ActiveRecord::Migration[5.1]
  def change
    remove_column :work_experiences, :from, :date
    remove_column :work_experiences, :to, :date
  end
end
