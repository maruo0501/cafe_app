require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  let(:user) { create(:user) }
  let(:new_post) { create(:post) }
  let(:other_user) { create(:user) }
  let(:another_user) { create(:another_user) }
  let!(:comment) { create(:comment, :user_id => user.id, :post_id => new_post.id) }
  let(:another_comment) { create(:comment, :user_id => another_user.id, :post_id => new_post.id) }
  describe "POST #create" do
    # ログイン済みのユーザーとして
      # 有効な属性値の場合
    context "with valid attributes" do
      # コメントを追加できること
      it "adds a comment" do
        comment_params = attributes_for(:comment, :user_id => user.id)
        sign_in user
        expect { post :create, :params => { :post_id => new_post.id, :comment => comment_params } }.to change(user.comments, :count).by(1)
      end
      # 他のユーザーに成り済ましてコメントできないこと
      it "does not add a comment as an other user" do
        comment_params = attributes_for(:comment, :user_id => other_user.id)
        sign_in user
        expect { post :create, :params => { :post_id => new_post.id, :comment => comment_params } }.to_not change(other_user.comments, :count)
      end
    end
    # 無効な属性値の場合
    context "with invalid attributes" do
      # コメントを追加できないこと
      it "does not add a comment" do
        comment_params = attributes_for(:comment, :comment_content => nil, :user_id => user.id)
        sign_in user
        expect { post :create, :params => { :post_id => new_post.id, :comment => comment_params } }.to_not change(user.comments, :count)
      end
    end
    # ログインしてないゲストユーザーとして
    context "as an guest user" do
      # 成り済まし投稿しようとするとエラーが発生すること
      it "does not add a comment and gets an error" do
        comment_params = attributes_for(:comment, :user_id => user.id)
        expect { post :create, :params => { :post_id => new_post.id, :comment => comment_params } }.to raise_error NameError
      end
    end
  end
  describe "DELETE #destroy" do
    # 認可されたユーザーとして
    context "as an authorized user" do
      # コメントを削除できること
      it "deletes a comment" do
        sign_in user
        expect {
          delete :destroy, :params => { :id => comment.id }
        }.to change(user.comments, :count).by(-1)
      end
    end
    # 認可されていないユーザーとして
    context "as an unauthenticated user" do
      # コメントを削除できないこと
      it "does not delete a comment" do
        sign_in another_user
        expect { delete :destroy, :params => { :id => another_comment.id } }.to_not change(user.comments, :count)
      end
      # ホーム画面にリダイレクトすること
      it "redirects to the dashboard" do
        sign_in another_user
        delete :destroy, :params => { :id => another_comment.id }
        expect(response).to redirect_to "/"
      end
    end
    # ログインしてないゲストユーザーとして
    context "as an guest user" do
      # 成り済まし削除しようとするとエラーが発生すること
      it "does not delete a comment and gets an error" do
        expect { delete :destroy, :params => { :id => comment.id } }.to raise_error NameError
      end
    end
  end
end