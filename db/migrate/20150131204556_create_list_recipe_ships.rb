class CreateListRecipeShips < ActiveRecord::Migration
  def change
    create_table :list_recipe_ships do |t|
      t.references :list_id, index: true
      t.references :recipe_id, index: true

      t.timestamps
    end
  end
end
