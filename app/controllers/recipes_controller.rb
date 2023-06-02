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
      return
    end

    @recipe_foods = RecipeFood.where(recipe: @recipe).includes(:food, :recipe)
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
      redirect_to @recipe, notice:
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

  def missing_food
    @foods = current_user.foods
    @foods.each do |food|
      food.quantity -= total_quantity_for_food(food)
    end

    @foods = @foods.select { |f| f.quantity.negative? }
    @foods.each { |f| f.quantity *= -1 }
    @total = calculate_total_price(@foods)
  end

  private

  def total_quantity_for_food(food)
    current_user.recipes.sum do |recipe|
      recipe.recipe_foods.includes(:food).where(food_id: food.id).sum(:quantity)
    end
  end

  def calculate_total_price(foods)
    foods.sum { |f| f.price * f.quantity }
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :description, :public)
  end
end
