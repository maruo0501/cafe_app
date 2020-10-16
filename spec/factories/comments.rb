FactoryBot.define do
  factory :comment do
    user_id {"1"}
    post_id {"1"}
    comment_content {"test comment"}
    association :user
    association :post
  end
end
