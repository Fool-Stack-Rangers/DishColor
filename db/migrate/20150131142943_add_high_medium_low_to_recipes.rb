class AddHighMediumLowToRecipes < ActiveRecord::Migration
  def change
  	add_column :recipes, :high, :string
  	add_column :recipes, :medium, :string
  	add_column :recipes, :low, :string
  end
end
