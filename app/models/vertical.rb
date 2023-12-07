class Vertical < ApplicationRecord
  has_many :categories

  validates_with VerticalCategoryNameValidator

  accepts_nested_attributes_for :categories
end
