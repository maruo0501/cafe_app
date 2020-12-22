require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do
  let(:user) { create(:user) }
  let(:new_post) { create(:post) }
  describe "POST #create" do
    # ログイン済みのユーザーとして
    context "as an authenticated user" do
      # いいね！が出来ること
      it "creates a favorite" do
        sign_in user
        expect { post :create, :params => { :user_id => user.id, :post_id => new_post.id } }.to change(user.favorites, :count).by(1)
      end
    end
    # ログインしてないゲストユーザーとして
    context "as an guest user" do
      # いいね！しようとするとエラーが発生すること
      it "does not create favorite for a post and gets an error" do
        expect { post :create, :params => { :user_id => user.id, :post_id => new_post.id } }.to raise_error NameError
      end
    end
  end
  describe "DELETE #destroy" do
    # ログイン済みのユーザーとして
    context "as an authenticated user" do
      # いいね！の取り消しが出来ること
      it "destroys a favorite" do
        sign_in user
        post :create, :params => { :user_id => user.id, :post_id => new_post.id }
        expect { delete :destroy, :params => { :user_id => user.id, :post_id => new_post.id } }.to change(user.favorites, :count).by(-1)
      end
    end
  end
end