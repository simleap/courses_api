FactoryBot.define do
  factory :category do
    name { Faker::Educator.unique.subject }
  end
end

