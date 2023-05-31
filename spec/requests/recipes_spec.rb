require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET' do
    before :all do
      @user = User.create(name: 'Test User')
      current_user = @user
    end
    
    describe '/index' do
      before :each do
        get recipes_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'renders the placeholder text' do
        expect(response.body).to include('You have no recipes yet!')
      end
    end

    describe '/public_recipes' do
      before :each do
        get public_recipes_recipes_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the public_recipes template' do
        expect(response).to render_template(:public_recipes)
      end

      it 'renders the placeholder text' do
        expect(response.body).to include('List of Public Recipes')
      end
    end

    describe '/show' do
      before :each do
        @recipe = Recipe.create(name: 'Test Recipe', prep_time: '10 minutes', cook_time: '20 minutes', description: 'Test description', public: true, author: @user)
        get recipe_path(@recipe)
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end

      it 'renders the recipe name' do
        expect(response.body).to include(@recipe.name)
      end

      it 'renders the recipe description' do
        expect(response.body).to include(@recipe.description)
      end
    end
  end
end