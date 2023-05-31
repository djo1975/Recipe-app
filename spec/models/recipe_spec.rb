require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'creation' do
    before :all do
      @user = User.create(name: 'John Doe')
      @recipe = Recipe.create(name: 'Chicken Parmesan', prep_time: '10 minutes', cook_time: '30 minutes', description: 'This is a description', author: @user)
    end

    it 'can be created' do
      expect(@recipe).to be_valid
    end
    
    it 'can be created with a public value that is a boolean' do
      @recipe.public = true
      expect(@recipe).to be_valid
    end

    it 'cannot be created without a name' do
      @recipe.name = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a name less than 3 characters' do
      @recipe.name = 'Ch'
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a name greater than 50 characters' do
      @recipe.name = 'C' * 51
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without a prep time' do
      @recipe.prep_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a prep time less than 5 characters' do
      @recipe.prep_time = '10'
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a prep time greater than 15 characters' do
      @recipe.prep_time = '1' * 16
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without a cook time' do
      @recipe.cook_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a cook time less than 5 characters' do
      @recipe.cook_time = '10'
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a cook time greater than 15 characters' do
      @recipe.cook_time = '1' * 16
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without a description' do
      @recipe.description = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a description less than 10 characters' do
      @recipe.description = 'This is a'
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a description greater than 300 characters' do
      @recipe.description = 'T' * 301
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without an author' do
      @recipe.author = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with an author that does not exist' do
      @recipe.author = User.new(name: 'Jane Doe')
      expect(@recipe).to_not be_valid
    end
    
    it 'cannot be created with a public value that is not a boolean' do
      @recipe.public = 'true'
      expect(@recipe).to_not be_valid
    end
  end
end