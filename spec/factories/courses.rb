FactoryBot.define do
  factory :course do
    name { Faker::Name.name }
    author { Faker::Name.name }
  end
end
