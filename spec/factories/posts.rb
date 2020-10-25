FactoryBot.define do
  factory :post do
    user_id { FactoryBot.create(:user).id }
    store_name {"test store"}
    content {"tester"}
    association :user #@postモデルは@userが投稿するので、関連付けを定義する。
  end
end