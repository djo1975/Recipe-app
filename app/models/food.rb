class Food < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :recipes, through: :food_recipes

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :measurement_unit, presence: true, length: { minimum: 2, maximum: 10 }
  validates :price, presence: true, numericality: { decimal: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
