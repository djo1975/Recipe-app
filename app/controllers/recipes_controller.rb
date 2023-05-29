class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :destroy]

  def index
    @recipes = current_user.recipes
  end

  def show
    unless @recipe.public || @recipe.author == current_user
      redirect_to recipes_path, alert: "You do not have access to that recipe."
    end

    @recipe_foods = @recipe.recipe_foods
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: "Recipe created successfully."
    else
      render :new, alert: "Failed to create recipe."
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to recipes_path, notice: "Recipe deleted successfully."
    else
      redirect_to recipes_path, alert: "Failed to delete recipe."
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :description)
  end
end
