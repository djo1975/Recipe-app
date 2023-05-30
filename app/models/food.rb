class Food < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :food_recipes, dependent: :destroy
  has_many :recipes, through: :food_recipes
end
