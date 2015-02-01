class ListRecipeShip < ActiveRecord::Base
  belongs_to :list
  belongs_to :recipe
end
