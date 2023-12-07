class Category < ApplicationRecord
  belongs_to :vertical, optional: true

  validates_with VerticalCategoryNameValidator
end
