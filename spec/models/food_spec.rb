require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'creation' do
    before :each do
      @user = User.create(name: 'John Doe')
      @food = Food.create(name: 'Chicken', measurement_unit: 'lbs', price: 1.99, quantity: 1, author: @user)
    end

    it 'can be created' do
      expect(@food).to be_valid
    end

    it 'cannot be created without a name' do
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a name less than 3 characters' do
      @food.name = 'Ch'
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a name greater than 50 characters' do
      @food.name = 'C' * 51
      expect(@food).to_not be_valid
    end

    it 'cannot be created without a measurement unit' do
      @food.measurement_unit = nil
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a measurement unit less than 2 characters' do
      @food.measurement_unit = 'l'
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a measurement unit greater than 10 characters' do
      @food.measurement_unit = 'l' * 11
      expect(@food).to_not be_valid
    end

    it 'cannot be created without a price' do
      @food.price = nil
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a price less than 0' do
      @food.price = -1
      expect(@food).to_not be_valid
    end

    it 'cannot be created without a quantity' do
      @food.quantity = nil
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a quantity less than 0' do
      @food.quantity = -1
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a quantity that is not an integer' do
      @food.quantity = 1.5
      expect(@food).to_not be_valid
    end

    it 'cannot be created without an author' do
      @food.author = nil
      expect(@food).to_not be_valid
    end
  end
end
