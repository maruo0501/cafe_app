FactoryBot.define do
  factory :user do
    name                  {"sample"}
    email                 {"sample@gmail.com"}
    password              {"123456"}
    encrypted_password    {"123456"}
  end
end