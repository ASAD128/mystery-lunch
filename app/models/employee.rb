class Employee < ApplicationRecord
  validates :name, presence: true
  belongs_to :department
  has_one_attached :image
end
