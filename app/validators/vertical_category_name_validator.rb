class VerticalCategoryNameValidator < ActiveModel::Validator
  def validate(record)
    if Vertical.exists?(name: record.name) || Category.exists?(name: record.name)
      record.errors.add(:name, 'is already taken.')
    end
  end
end
