class CreateMasterAccount < ActiveRecord::Migration[7.0]
  def change
    # t.references :manager, foreign_key: { to_table: :users }
    add_reference :users, :manager, foreign_key:  { to_table: :users }
  end
end
