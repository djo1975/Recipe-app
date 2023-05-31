require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before :all do
      @user1 = User.create(name: 'John Doe')
      @user2 = User.create(name: 'Jane Doe')
    end

    it 'can be created' do
      expect(@user1).to be_valid
      expect(@user2).to be_valid
    end

    it 'cannot be created without a name' do
      @user1.name = nil
      @user2.name = nil
      expect(@user1).to_not be_valid
      expect(@user2).to_not be_valid
    end

    it 'cannot be created with a name less than 3 characters' do
      @user1.name = 'Jo'
      @user2.name = 'Ja'
      expect(@user1).to_not be_valid
      expect(@user2).to_not be_valid
    end

    it 'cannot be created with a name greater than 50 characters' do
      @user1.name = 'J' * 51
      @user2.name = 'J' * 51
      expect(@user1).to_not be_valid
      expect(@user2).to_not be_valid
    end
  end
end