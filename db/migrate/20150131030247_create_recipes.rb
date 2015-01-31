class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :photo_id

      t.timestamps
    end
  end
end
