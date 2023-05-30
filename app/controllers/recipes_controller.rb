class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy update]

  def index
    @recipes = current_user.recipes.includes(:author).order(created_at: :desc)
  end

  def public_recipes
    @recipes = Recipe.where(public: true).includes(:author, :foods).order(created_at: :desc)
  end

  def show
    unless @recipe.public || @recipe.author == current_user
      redirect_to recipes_path, alert: 'You do not have access to that recipe.'
    end

    @recipe_foods = RecipeFood.where(recipe: @recipe).includes(:food, :recipe)
    @total_food_items = @recipe_foods.count

    @total_price = @recipe_foods.sum { |recipe_food| recipe_food.food.price * recipe_food.food.quantity }
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe created successfully.'
    else
      render :new, alert: 'Failed to create recipe.'
    end
  end

  def update
    if @recipe.update(recipe_params)
      notice = @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
      redirect_to @recipe, notice: notice
    else
      redirect_to @recipe, alert: 'Failed to update recipe.'
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe deleted successfully.'
    else
      redirect_to recipes_path, alert: 'Failed to delete recipe.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.includes(:author).find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :description, :public)
  end
end
