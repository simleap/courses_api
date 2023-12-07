class Vertical < ApplicationRecord
  has_many :categories

  validates_with VerticalCategoryNameValidator, if: :name_changed?

  accepts_nested_attributes_for :categories
end
