class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(6).order(created_at: :desc)
  end

  def show
    @user = @post.user
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def update
    if @post.update(update_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  private
  def post_params
    params.permit(:store_name, :content, :image, :authenticity_token, :commit, :wifi, :power, :creditcard)
  end

  def update_params
    params.require(:post).permit(:store_name, :content, :image, :commit, :wifi, :power, :creditcard)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end

