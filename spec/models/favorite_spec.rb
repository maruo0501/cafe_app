require 'rails_helper'

RSpec.describe Favorite, :type => :model do
  it "user_id、post_idがある場合有効である" do
    favorite = create(:favorite)
    expect(favorite).to be_valid
  end
  it "user_idがない場合はお気に入りできないこと" do
    favorite = build(:favorite, :user_id => nil)
    expect(favorite).not_to be_valid
  end
  it "post_idがない場合はお気に入りできないこと" do
    favorite = build(:favorite, :post_id => nil)
    expect(favorite).not_to be_valid
  end
end
