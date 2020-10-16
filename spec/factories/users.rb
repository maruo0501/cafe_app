FactoryBot.define do
  factory :user do
    name                  {"test"}
    sequence(:email) { |n| "tester#{n}@example.com" }
    password              {"123456"}
    encrypted_password    {"123456"}
  end
end