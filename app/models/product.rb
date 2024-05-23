class Product < ApplicationRecord

  cattr_accessor :reprocessing_request

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }
  validates :position, presence: true

  scope :ordered, -> { order(updated_at: :desc) }
end
