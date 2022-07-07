class RenameClients < ActiveRecord::Migration[7.0]
  def change
    rename_table :clients, :cabinents
  end
end
