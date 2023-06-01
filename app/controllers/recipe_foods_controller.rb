class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to @recipe, notice: 'Ingredient added successfully.'
    else
      render :new, alert: 'Failed to add ingredient.'
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food.update(recipe_food_params)
      redirect_to @recipe, notice: 'Ingredient updated successfully.'
    else
      render :edit, alert: 'Failed to update ingredient.'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food.destroy
      redirect_to @recipe, notice: 'Ingredient deleted successfully.'
    else
      redirect_to @recipe, alert: 'Failed to delete ingredient.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
