class ChangeAccount < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :user_id
    add_reference :users, :account, foreign_key: true
  end
end
