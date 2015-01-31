class ListRecipeShip < ActiveRecord::Base
  belongs_to :list_id
  belongs_to :recipe_id
end
