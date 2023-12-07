class Vertical < ApplicationRecord
  validates_with VerticalCategoryNameValidator
end
