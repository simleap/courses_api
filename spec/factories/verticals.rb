FactoryBot.define do
  factory :vertical do
    name { Faker::Educator.unique.subject }
  end
end

