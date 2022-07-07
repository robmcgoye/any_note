class RenameColFolder < ActiveRecord::Migration[7.0]
  def change
    rename_column :folders, :cabinent_id, :cabinet_id
  end
end
