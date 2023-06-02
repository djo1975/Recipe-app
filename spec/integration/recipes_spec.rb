require 'rails_helper'

RSpec.describe 'Recipes', type: :system, js: true do
  before :example do
    @messi = User.create(name: 'Messi', email: 'messi@goat.com', password: 'password')

    @recipe = Recipe.create(name: 'Burger', prep_time: '10 minutes', cook_time: '15 minutes',
                            description: 'Delicious burger', public: true, author: @messi)
    @recipe2 = Recipe.create(name: 'Pizza', prep_time: '10 minutes', cook_time: '20 minutes',
                             description: 'Delicious pizza', public: true, author: @messi)
    @recipe3 = Recipe.create(name: 'Pasta', prep_time: '10 minutes', cook_time: '25 minutes',
                             description: 'Delicious pasta', public: true, author: @messi)
  end

  describe 'index page' do
    before :example do
      sign_in @messi
      visit recipes_path
    end

    it 'shows the recipes' do
      expect(page).to have_content('Burger')
      expect(page).to have_content('Pizza')
      expect(page).to have_content('Pasta')
    end

    it 'shows the recipe details' do
      click_on 'Burger'
      expect(page).to have_content('Delicious burger')
    end
  end

  describe 'show page' do
    before :example do
      sign_in @messi
      visit recipe_path(@recipe2)
    end

    it 'shows the recipe details' do
      expect(page).to have_content('Delicious pizza')
      expect(page).to have_content('Preparation time: 10 minutes')
      expect(page).to have_content('Cooking time: 20 minutes')
      expect(page).to have_content('Public')
    end
  end
end
