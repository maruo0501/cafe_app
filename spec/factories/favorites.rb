FactoryBot.define do
  factory :favorite do
    user_id {"1"}
    post_id {"1"}
    association :user
    association :post
  end
end
