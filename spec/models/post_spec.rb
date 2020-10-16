require 'rails_helper'

RSpec.describe Post, type: :model do
  it "store_name、content、user_idがある場合有効である" do
    post = create(:post)
    expect(post).to be_valid
  end

  it "store_nameがない場合は登録できないこと" do
    post = build(:post, store_name: nil)
    post.valid?
    expect(post.errors[:store_name]).to include("を入力してください")
  end

  it "contentがない場合は投稿できないこと" do
    post = build(:post, content: nil)
    post.valid?
    expect(post.errors[:content]).to include("を入力してください")
  end

  it "user_idがない場合は投稿できないこと" do
    post = build(:post, user_id: nil)
    expect(post).not_to be_valid
  end
  
  it "store_nameが21文字以上であれば投稿できないこと" do
    post = build(:post, store_name: "a" * 21)
    expect(post).not_to be_valid
  end

  it "contentは141文字以上であれば投稿できないこと" do
    post = build(:post, content: "a" * 141)
    expect(post).not_to be_valid
  end

  describe "post association" do
    it {have_many :favorites}
    it {have_many :comments}
  end
end