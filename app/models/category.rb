class Category < ApplicationRecord
  belongs_to :vertical, optional: true
end
