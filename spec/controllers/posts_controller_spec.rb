require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
    @post = @user.posts.create(
        store_name: "test store",
        content: "tester",
        user_id: 1
      ) 
  end

  describe "#index" do
    # 正常なレスポンスか？
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
    # 200レスポンスが返ってきているか？
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#show" do
    it "responds successfully" do
      get :show, params: {id: @post.id}
      expect(response).to be_successful
    end
    it "returns a 200 response" do
      get :show, params: {id: @post.id}
      expect(response).to have_http_status "200"
    end
  end

  describe "#new" do
    context "as an authorized user" do
      # 正常なレスポンスか？
      it "responds successfully" do
        sign_in @user
        get :new
        expect(response).to be_successful
      end
      # 200レスポンスが返ってきているか？
      it "returns a 200 response" do
        sign_in @user
        get :new
        expect(response).to have_http_status "200"
      end
    end
    context "as a guest user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        get :new
        expect(response).to_not be_successful
      end
      # 302レスポンスが返ってきているか？
      it "returns a 302 response" do
        get :new
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sign_in" do
        get :new
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      # 正常に投稿を作成できるか？
      it 'adds a new post' do
        sign_in @user 
        expect {
          post :create, params: {
              store_name: "test",
              content: "test",
              user_id: 1
          }
        }.to change(@user.posts, :count).by(1)
      end
      # 投稿作成後に作成した投稿一覧ページへリダイレクトされているか？
      it "redirects the page to /posts/index" do
        sign_in @user
        post :create, params: {
              store_name: "test",
              content: "test",
              user_id: 1
        }
        expect(response).to redirect_to "/posts/index"
      end
    end
    context "with invalid attributes" do
      # 不正なアトリビュートを含む投稿は作成できなくなっているか？
      it "does not add a new post" do
        sign_in @user
        expect {
          post :create, params: {
              store_name: nil,
              content: "test",
              user_id: 1
          }
        }.to_not change(@user.posts, :count)
      end
      # 不正な投稿を作成しようとすると、再度投稿ページへリダイレクトされるか？
      it "redirects the page to /posts/new" do
        sign_in @user
        post :create, params: {store_name: nil, content: "test", user_id: 1}
        expect(response).to redirect_to("/posts/new")
        # "/posts/new"
      end
    end
    context "as a guest user" do
      # 302レスポンスが返ってきているか？
      it "returns a 302 request" do
        get :create
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sign_in" do
        get :create
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#edit" do
    context "as an authorized user" do
      # 正常なレスポンスか？
      it "responds successfully" do
        sign_in @user
        get :edit, params: {id: @post.id}
        expect(response).to be_successful
      end
      # 200レスポンスが返ってきているか？
      it "returns a 200 response" do
        sign_in @user
        get :edit, params: {id: @post.id}
        expect(response).to have_http_status "200"
      end
    end
    context "as an unauthorized user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        sign_in @another_user
        get :edit, params: {id: @post.id}
        expect(response).to_not be_successful
      end
      # 他のユーザーが記事を編集しようとすると、ルートページへリダイレクトされているか？
      it "redirects the page to /posts/index" do
        sign_in @another_user
        get :edit, params: {id: @post.id}
        expect(response).to redirect_to "/posts/index"
      end
    end
    context "as a guest user" do
      # 302レスポンスが返ってきているか？
      it "returns a 302 response" do
        get :edit, params: {id: @post.id}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sign_in" do
        get :edit, params: {id: @post.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      # 正常に投稿を更新できるか？
      it "updates a post" do
        sign_in @user
        post_params = {store_name: "test store"}
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.store_name).to eq "test store"
      end
      # 投稿を更新した後、投稿一覧ページへリダイレクトするか？
      it "redirects the page to /posts/index" do
        sign_in @user
        post_params = {store_name: "test store"}
        patch :update, params: {id: @post.id, post: post_params}
        expect(response).to redirect_to "/posts/index"
      end
    end
    context "with invalid attributes" do
      # 不正なアトリビュートを含む投稿は更新できなくなっているか？
      it "does not update an article" do
        sign_in @user
        post_params = {store_name: nil}
        patch :update, params: {id: @post.id, post: post_params}
        expect(@post.reload.store_name).to eq "test store"
      end
      # 不正な投稿を更新しようとすると、再度更新ページへリダイレクトされるか？
      it "redirects the page to /posts/edit" do
        sign_in @user
        post_params = {store_name: nil}
        patch :update, params: {id: @post.id, post: post_params}
        expect(response).to redirect_to("/posts/edit")
        # "/posts/1/edit"
      end
    end
    context "as an unauthorized user" do
      # 正常なレスポンスが返ってきていないか？
      it "does not respond successfully" do
        sign_in @another_user
        get :edit, params: {id: @post.id}
        expect(response).to_not be_successful
      end
      # 他のユーザーが投稿を編集しようとすると、投稿一覧ページへリダイレクトされているか？
      it "redirects the page to /posts/index" do
        sign_in @another_user
        get :edit, params: {id: @post.id}
        expect(response).to redirect_to "/posts/index"
      end
    end
    context "as a guest user" do
      # 302レスポンスを返すか？
      it "returns a 302 response" do
        post_params = {
          store_name: "test store",
          content: "tester",
          user_id: 1
        }
        patch :update, params: {id: @post.id, post: post_params}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sign_in" do
        post_params = {
          store_name: "test store",
          content: "tester",
          user_id: 1
        }
        patch :update, params: {id: @post.id, post: post_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      # 正常に投稿を削除できるか？
      it "deletes a post" do
        sign_in @user
        expect {
          delete :destroy, params: {id: @post.id}
        }.to change(@user.posts, :count).by(-1)
      end
      # 投稿を削除した後、投稿一覧ページへリダイレクトしているか？
      it "redirects the page to /posts/index" do
        sign_in @user
        delete :destroy, params: {id: @post.id}
        expect(response).to redirect_to "/posts/index"
      end
    end
    context "as an unauthorized user" do
      # 投稿したユーザーだけが、投稿を削除できるようになっているか？
      it "does not delete a post" do
        sign_in @user
        another_post = @another_user.posts.create(
          store_name: "sample",
          content: "sampler"
        )
        expect {
          delete :destroy, params: {id: another_post.id}
        }.to_not change(@another_user.posts, :count)
      end
      # 他のユーザーが投稿を削除しようとすると、ルートページへリダイレクトされるか？
      it "redirects the page to /posts/index" do
        sign_in @user
        another_post = @another_user.posts.create(
          store_name: "sample",
          content: "sampler"
        )
        delete :destroy, params: {id: another_post.id}
        expect(response).to redirect_to "/posts/index"
      end
    end
    context "as a guest user" do
      # 302レスポンスを返すか？
      it "returns a 302 response" do
        delete :destroy, params: {id: @post.id}
        expect(response).to have_http_status "302"
      end
      # ログイン画面にリダイレクトされているか？
      it "redirects the page to /users/sing_in" do
        delete :destroy, params: {id: @post.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end