class RemoveManRef < ActiveRecord::Migration[7.0]
  def change
    remove_reference :accounts, :manager
  end
end
