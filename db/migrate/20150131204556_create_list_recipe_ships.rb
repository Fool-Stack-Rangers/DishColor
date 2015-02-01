class CreateListRecipeShips < ActiveRecord::Migration
  def change
    create_table :list_recipe_ships do |t|
      t.references :list, index: true
      t.references :recipe, index: true

      t.timestamps
    end
  end
end
