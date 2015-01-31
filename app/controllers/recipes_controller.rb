class RecipesController < ApplicationController
  before_action :authenticate_user!, :only => [:index, :new, :create, :edit,:update,:destroy]
  before_action :set_recipe, only: [:edit, :update, :destroy]
  
  respond_to :html

  def index
    @recipes = current_user.recipes.all
    respond_with(@recipes)
  end

  def show
    @recipe = Recipe.find(params[:id])
    # respond_with(@recipe)
  end

  def new
    @recipe = current_user.recipes.new
    respond_with(current_user,@recipe)
  end

  def edit
  end

  def create
    @user = current_user
    @recipe = @user.recipes.build(recipe_params)
    flash[:notice] = 'Recipe was successfully created.' if @recipe.save
    respond_with(current_user,@recipe)
  end

  def update
    flash[:notice] = 'Recipe was successfully updated.' if @recipe.update(recipe_params)
    respond_with(current_user,@recipe)
  end

  def destroy
    @recipe.destroy
    respond_with(current_user,@recipe)
  end

  private
    def set_recipe
       @user = current_user
        if @user.recipes.find(params[:id]) != nil 
          @recipe = @user.recipes.find(params[:id])        
        else
          redirect_to action: 'index'
        end
    end

    def recipe_params
      params.require(:recipe).permit(:id, :name, :description, :user_id, :image_id, :image)
    end
end
