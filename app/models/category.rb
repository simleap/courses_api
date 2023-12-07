class Category < ApplicationRecord
  belongs_to :vertical, optional: true
  has_many :courses

  validates_with VerticalCategoryNameValidator

  accepts_nested_attributes_for :courses
end
