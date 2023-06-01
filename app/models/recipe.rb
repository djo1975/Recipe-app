class Recipe < ApplicationRecord
  belongs_to :author, class_name: 'User'
  # has_many :recipe_foods
  # has_many :foods, through: :recipe_foods

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :prep_time, :cook_time, presence: true, length: { minimum: 5, maximum: 15 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :public, inclusion: { in: [true, false] }
end
