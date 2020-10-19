FactoryBot.define do
  factory :user, class: User do 
    name                  {"test"}
    sequence(:email) { |n| "tester#{n}@example.com" }
    password              {"123456"}
    encrypted_password    {"123456"}
  end
  factory :another_user, class: User do 
    name                  {"test2"}
    sequence(:email) { |n| "tester2#{n}@example.com" }
    password              {"234567"}
    encrypted_password    {"234567"}
  end
end