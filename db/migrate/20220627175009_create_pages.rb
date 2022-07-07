class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :name
      t.text :body

      t.timestamps
    end

    create_table :tiny_images do |t|
      t.string :file
      t.string :alt

      t.timestamps
    end

    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.timestamps
    end

    add_reference :cabinents, :account, foreign_key: true
  end
end
