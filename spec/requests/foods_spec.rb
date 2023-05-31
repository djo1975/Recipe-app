require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  describe 'GET' do
    before :all do
      @user = User.create(name: 'Test User')
      current_user = @user
    end

    describe '/index' do
      before :each do
        get foods_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'renders the placeholder text' do
        expect(response.body).to include('Measurement_unit')
      end
    end

    describe '/new' do
      before :each do
        get new_food_path
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'renders the placeholder text' do
        expect(response.body).to include('New Food')
      end
    end   
  end
end
