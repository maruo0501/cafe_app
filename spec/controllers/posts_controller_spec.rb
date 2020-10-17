require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
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
      # expect(response).to have_http_status "200"
      expect(response.status).to eq(200)
    end
  end

  describe "#show" do
    it "responds successfully" do
      get :show, params: {id: @post.id}
      expect(response).to be_successful
    end
    it "returns a 200 response" do
      get :show, params: {id: @post.id}
      expect(response.status).to eq(200)
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
        expect do
          post :create, params: { post: FactoryBot.create(:post) }
        end.to change(Post, :count).by(1)
      end

      # 投稿作成後に作成した投稿一覧ページへリダイレクトされているか？
      # it "redirects the page to /posts/index" do
      #   sign_in @user
      #   post :create, params: {
      #     post: {
      #       store_name: "test store",
      #       content: "tester",
      #       user_id: 1
      #     }
      #   }
      #   # post :create, params: { post: FactoryBot.create(:post) }
      #   # post :create, params: { post: FactoryBot.attributes_for(:post) }
      #   expect(response).to redirect_to "/posts/index"
        # expect(response).to redirect_to root_path
      # end
    end
    context "with invalid attributes" do
      # 不正なアトリビュートを含む投稿は作成できなくなっているか？
      it "does not add a new post" do
        sign_in @user
        expect {
          post :create, params: {
            post: {
              store_name: nil,
              content: "tester",
              user_id: 1
            }
          }
        }.to_not change(@user.posts, :count)
      end
      # 不正な投稿を作成しようとすると、再度投稿ページへリダイレクトされるか？
      # it "redirects the page to /posts/new" do
      #   sign_in @user
      #   post :create, params: {
      #     post: {
      #       store_name: nil,
      #       content: "tester",
      #       user_id: 1
      #     }
      #   }
      #   expect(response).to redirect_to "/posts/new"
      # end
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





end