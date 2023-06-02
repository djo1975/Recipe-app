class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy update]

  def index
    @recipes = current_user.recipes.includes(:author).order(created_at: :desc)
  end

  def public_recipes
    @recipes = Recipe.where(public: true).includes(:author, :foods).order(created_at: :desc)
  end

  def missing_food
    recipe_food_ids = RecipeFood.where(recipe_id: current_user.recipes.pluck(:id)).pluck(:food_id)
    all_foods = Food.includes(:author)
    @missing_foods = find_missing_foods(current_user, recipe_food_ids, all_foods)
    @total_items = calculate_total_food_items(@missing_foods)
    @total_price = calculate_total_price(@missing_foods)
  end

  def show
    puts 'Inside show method' # Dodajte ovaj red

    unless @recipe.public || @recipe.author == current_user
      redirect_to recipes_path, alert: 'You do not have access to that recipe.'
      return
    end
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id).includes(food: :author)
    recipe_food_ids = @recipe_foods.pluck(:food_id)
    all_foods = Food.includes(:author)
    @missing_foods = find_missing_foods(current_user, recipe_food_ids, all_foods)
    @total_items = calculate_total_food_items(@missing_foods)
    @total_price = calculate_total_price(@missing_foods)
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

  private

  def set_recipe
    @recipe = if current_user
                Recipe.where(id: params[:id]).where('author_id = ? OR public = ?', current_user.id, true).first
              else
                Recipe.where(id: params[:id], public: true).first
              end
    return if @recipe

    redirect_to recipes_path, alert: 'Recipe not found.'
    nil
  end

  def recipe_params
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :description, :public)
  end

  def find_missing_foods(_user, recipe_food_ids, all_foods)
    missing_foods = []
    recipe_food_ids.uniq.each do |recipe_food_id|
      food = all_foods.find_by(id: recipe_food_id)
      next unless food

      required_quantity = RecipeFood.where(recipe_id: recipe_food_ids, food_id: food.id).sum(:quantity)
      available_quantity = food.quantity

      next unless available_quantity < required_quantity

      missing_foods << {
        food:,
        quantity_needed: required_quantity - available_quantity
      }
    end

    missing_foods
  end

  def calculate_total_food_items(foods)
    foods.size
  end

  def calculate_total_price(foods)
    foods.sum { |food| food[:food].price * food[:quantity_needed] }
  end
end
