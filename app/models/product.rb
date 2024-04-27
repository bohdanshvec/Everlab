class Product < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }
  validates :position, presence: true
end
