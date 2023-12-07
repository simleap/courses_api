FactoryBot.define do
  factory :application, class: "Doorkeeper::Application" do
    sequence(:name) { |n| "Project #{n}" }
    redirect_uri { "https://myapp.com" }
  end
end
