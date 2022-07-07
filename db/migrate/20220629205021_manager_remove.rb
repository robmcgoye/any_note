class ManagerRemove < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :manager
  end
end
