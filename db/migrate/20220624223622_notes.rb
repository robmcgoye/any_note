class Notes < ActiveRecord::Migration[7.0]
  def change

    create_table :folders do |t|
      t.string :title
      t.references :subfolder, foreign_key: { to_table: :folders }
      t.references :client, null: false, foreign_key: true
      t.timestamps
    end

    create_table :notes do |t|
      t.string :title
      t.text :content
      t.references :folder, null: false, foreign_key: true
      t.timestamps    
    end

  end
end
