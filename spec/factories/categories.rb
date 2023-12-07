FactoryBot.define do
  factory :category do
    name { Faker::Educator.subject }
    vertical
  end
end

