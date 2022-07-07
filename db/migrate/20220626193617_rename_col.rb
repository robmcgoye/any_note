class RenameCol < ActiveRecord::Migration[7.0]
  def change
    rename_column :folders, :client_id, :cabinent_id
  end
end
