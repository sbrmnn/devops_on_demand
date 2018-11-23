class RenameTitleToHeadlineInFreelancer < ActiveRecord::Migration[5.1]
  def change
    rename_column :freelancers, :title, :headline
  end
end
