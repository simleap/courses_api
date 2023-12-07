FactoryBot.define do
  factory :vertical do
    name { Faker::Job.field }

    trait :with_category_course do
      after(:create) do |vertical|
        category = create :category, vertical: vertical
        create :course, category: category
      end
    end
  end
end

