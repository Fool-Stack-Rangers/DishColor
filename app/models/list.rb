class List < ActiveRecord::Base
  belongs_to :user
  has_many :recipes, through: :list_recipe_ships
  has_many :list_recipe_ships

  accepts_nested_attributes_for :recipes
end
