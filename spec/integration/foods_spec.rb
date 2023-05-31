require 'rails_helper'

RSpec.describe 'Foods', type: :system, js: true do
  before :example do
    @cr7 = User.create(name: 'CR7')
    current_user = @cr7
    @banana = Food.create(name: 'Banana', measurement_unit: 'units', price: 1.5, quantity: 10, author: @cr7)
    @flour = Food.create(name: 'Flour', measurement_unit: 'kg', price: 2.5, quantity: 20, author: @cr7)
    @sugar = Food.create(name: 'Sugar', measurement_unit: 'kg', price: 3.5, quantity: 30, author: @cr7)
  end

  describe 'index page' do
    before :example do
      visit foods_path
    end

    it 'shows the foods details' do
      expect(page).to have_content('Banana')
      expect(page).to have_content('kg')
      expect(page).to have_content('3.5')
    end
  end
end