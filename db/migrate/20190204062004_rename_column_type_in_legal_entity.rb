class RenameColumnTypeInLegalEntity < ActiveRecord::Migration[5.1]
  def change
    rename_column :legal_entities, :type, :entity_type
  end
end
