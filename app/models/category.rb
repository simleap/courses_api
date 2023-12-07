class Category < ApplicationRecord
  belongs_to :vertical, optional: true
  has_many :courses

  validates_with VerticalCategoryNameValidator, if: :name_changed?

  accepts_nested_attributes_for :courses
end
