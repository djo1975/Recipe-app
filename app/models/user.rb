class User < ApplicationRecord
  has_many :recipes, foreign_key: :author_id, dependent: :destroy
  has_many :foods, foreign_key: :author_id, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
end
