require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "comment_content、user_id、post_idがある場合有効である" do
    comment = create(:comment)
    expect(comment).to be_valid
  end
  it "comment_contentがない場合は投稿できないこと" do
    comment = build(:comment, comment_content: nil)
    comment.valid?
    expect(comment.errors[:comment_content]).to include("を入力してください")
  end
  it "user_idがない場合は投稿できないこと" do
    comment = build(:comment, user_id: nil)
    expect(comment).not_to be_valid
  end
  it "post_idがない場合は投稿できないこと" do
    comment = build(:comment, post_id: nil)
    expect(comment).not_to be_valid
  end
  it "comment_contentが141文字以上であれば投稿できないこと" do
    comment = build(:comment, post_id: "a" * 141)
    expect(comment).not_to be_valid
  end
end
