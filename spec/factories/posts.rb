FactoryBot.define do
  factory :post do
    user_id {"1"}
    store_name {"test_store"}
    content {"tester"}
    association :user #@postモデルは@userが投稿するので、関連付けを定義する。
  end
end