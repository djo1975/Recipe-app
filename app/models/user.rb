class User < ApplicationRecord
  has_many :recipes, foreign_key: :author_id, dependent: :destroy
  has_many :foods, foreign_key: :author_id, dependent: :destroy
end
