class ListsController < ApplicationController
  def index

  end

  def show
    @list = List.find(params[:id])
  end

  def create
    recipe_ids = params[:recipe_ids]
    recipe_ids = recipe_ids.split(',').uniq
    @list = current_user.lists.build

    if @list.save
      recipe_ids.each do |id|
        @list.recipes << Recipe.find(id.to_i)
      end
      redirect_to list_path(@list)
    else
      render recommendation_path
    end
  end

end
