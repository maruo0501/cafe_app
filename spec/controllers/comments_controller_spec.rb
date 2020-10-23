require 'rails_helper'
# require 'comments_controller'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    # ログイン済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = create(:user)
        @post = create(:post)
      end

       # 有効な属性値の場合
       context "with valid attributes" do
        # コメントを追加できること
        it "adds a comment" do
          comment_params = attributes_for(:comment, user_id: @user.id)
          sign_in @user
          expect {post :create, params: {post_id: @post.id, comment: comment_params}}.to change(@user.comments, :count).by(1)
        end

         # 他のユーザーに成り済ましてコメントできないこと
         it "does not add a comment as an other user" do
          other_user = create(:user)
          comment_params = attributes_for(:comment, user_id: other_user.id)
          sign_in @user
          expect {post :create, params: {post_id: @post.id, comment: comment_params}}.to_not change(other_user.comments, :count)
        end
      end

      # 無効な属性値の場合
      context "with invalid attributes" do
        # コメントを追加できないこと
        it "does not add a comment" do
          comment_params = attributes_for(:comment, comment_content: nil, user_id: @user.id)
          sign_in @user
          expect{post :create, params: {post_id: @post.id, comment: comment_params}}.to_not change(@user.comments, :count)
        end
      end
    end

    # ログインしてないゲストユーザーとして
    context "as an guest user" do
      before do
        @user = create(:user)
        @post = create(:post)
      end

      # 成り済まし投稿しようとするとエラーが発生すること
      it "does not add a comment and gets an error" do
        comment_params = attributes_for(:comment, user_id: @user.id)
        expect {post :create, params: {post_id: @post.id, comment: comment_params}}.to raise_error NameError
      end
    end
  end

  describe "DELETE #destroy" do
    # 認可されたユーザーとして
    context "as an authorized user" do
      before do
        @user = create(:user)
        @post = create(:post)
        @comment = create(:comment, user_id: @user.id, post_id: @post.id)
      end

      # コメントを削除できること
      it "deletes a comment" do
        sign_in @user
        # expect{delete :destroy, params: {id: @comment.id}}.to change(@user.comments, :count).by(-1)
        # post :create, params: {user_id: @user.id, post_id: @post.id}
        # expect{delete :destroy, params: {user_id: @user.id, post_id: @post.id}}.to change(@user.comments, :count).by(-1)
        expect {
          delete :destroy, params: {id: @comment.id}
        }.to change(@user.comments, :count).by(-1)
      end
    end

    # 認可されていないユーザーとして
    context "as an unauthenticated user" do
      before do
        @user = create(:user)
        @another_user = FactoryBot.create(:another_user)
        @post = create(:post)
        @comment = create(:comment, user_id: @another_user.id, post_id: @post.id)
      end

      # コメントを削除できないこと
      it "does not delete a comment" do
        sign_in @another_user
        expect{delete :destroy, params: {id: @comment.id}}.to_not change(@user.comments, :count)
      end

      # ホーム画面にリダイレクトすること
      it "redirects to the dashboard" do
        sign_in @another_user
        delete :destroy, params: {id: @comment.id}
        expect(response).to redirect_to "/"
      end
    end

     # ログインしてないゲストユーザーとして
     context "as an guest user" do
      before do
        @user = create(:user)
        @post = create(:post)
        @comment = create(:comment, user_id: @user.id, post_id: @post.id)
      end

       # 成り済まし削除しようとするとエラーが発生すること
       it "does not delete a comment and gets an error" do
        expect {delete :destroy, params: {id: @comment.id}}.to raise_error NameError
      end
    end
  end
end