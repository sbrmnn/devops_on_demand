class RenameColumnNameToSchoolNameInEducation < ActiveRecord::Migration[5.1]
  def change
    rename_column :educations, :name, :school_name
  end
end
