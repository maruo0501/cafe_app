require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do
  describe "POST #create" do
    # ログイン済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = create(:user)
        @post = create(:post)
      end
      it "returns http success" do
        sign_in @user
        post :create, :params => { :user_id => @user.id, :post_id => @post.id }
        expect(response).to have_http_status(:success)
      end
      # いいね！が出来ること
      it "creates a favorite" do
        sign_in @user
        expect { post :create, :params => { :user_id => @user.id, :post_id => @post.id } }.to change(@user.favorites, :count).by(1)
      end
    end
    # ログインしてないゲストユーザーとして
    context "as an guest user" do
      before do
        @user = create(:user)
        @post = create(:post)
      end
      # いいね！しようとするとエラーが発生すること
      it "does not create favorite for a post and gets an error" do
        expect { post :create, :params => { :user_id => @user.id, :post_id => @post.id } }.to raise_error NameError
      end
    end
  end
  describe "DELETE #destroy" do
    # ログイン済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = create(:user)
        @post = create(:post)
      end
      # いいね！の取り消しが出来ること
      it "destroys a favorite" do
        sign_in @user
        post :create, :params => { :user_id => @user.id, :post_id => @post.id }
        expect { delete :destroy, :params => { :user_id => @user.id, :post_id => @post.id } }.to change(@user.favorites, :count).by(-1)
      end
    end
  end
end