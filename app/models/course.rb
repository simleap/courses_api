class Course < ApplicationRecord
  belongs_to :category, optional: true
end
