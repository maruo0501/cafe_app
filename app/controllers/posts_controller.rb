class PostsController < ApplicationController
  # before_action :ensure_correct_user, {only: [:edit, :update, :destroy, :create]}

  def index
    # @posts = Post.all.order(created_at: :desc)
    @posts = Post.page(params[:page]).per(6).order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    # 追記
    @user = @post.user
    @comments = @post.comments
    @comment = @post.comments.build
    # @comment = current_user.comments.new 
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(post_params)
    # 追記
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(update_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  # def ensure_correnct_user
  #   @post = Post.find_by(id: params[:id])
  #   if @post.user_id != @current_user.id
  #     flash[:notice] = "権限がありません"
  #     redirect_to("/posts/index")
  #   end
  # end

  # private
  def post_params
    params.permit(:store_name, :content, :image, :authenticity_token, :commit, :wifi, :power, :creditcard)
  end
  def update_params
    params.require(:post).permit(:store_name, :content, :image, :commit, :wifi, :power, :creditcard)
  end
end

