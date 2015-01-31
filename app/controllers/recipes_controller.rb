class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @recipes = Recipe.all
    respond_with(@recipes)
  end

  def show
    respond_with(@recipe)
  end

  def new
    @recipe = Recipe.new
    respond_with(@recipe)
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)
    flash[:notice] = 'Recipe was successfully created.' if @recipe.save
    respond_with(@recipe)
  end

  def update
    flash[:notice] = 'Recipe was successfully updated.' if @recipe.update(recipe_params)
    respond_with(@recipe)
  end

  def destroy
    @recipe.destroy
    respond_with(@recipe)
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name, :description, :user_id, :photo_id)
    end
end
