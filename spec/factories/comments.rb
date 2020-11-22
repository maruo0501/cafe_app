FactoryBot.define do
  factory :comment do
    user_id { FactoryBot.create(:user).id }
    post_id { FactoryBot.create(:post).id }
    comment_content { "test comment" }
    association :user
    association :post
  end
end
