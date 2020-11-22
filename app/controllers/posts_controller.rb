class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :ensure_correct_user, { :only => [:edit, :update, :destroy] }
  before_action :set_post, :only => [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(6).order(:created_at => :desc)
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
      redirect_to("/posts/index")
      flash[:notice] = "投稿を作成しました"
    else
      flash[:alert] = "投稿を作成できませんでした"
      render("posts/new")
    end
  end

  def update
    if @post.update(update_params)
      redirect_to("/posts/index")
      flash[:notice] = "投稿を編集しました"
    else
      flash[:alert] = "投稿を編集できませんでした"
      render("posts/edit")
    end
  end

  def destroy
    if @post.destroy
      redirect_to("/posts/index")
      flash[:notice] = "投稿を削除しました"
    else
      flash[:alert] = "投稿を削除できませんでした"
      redirect_back(:fallback_location => root_path)  
    end
  end

  def ensure_correct_user
    @post = Post.find_by(:id => params[:id])
    if @post.user_id != current_user.id
      redirect_to("/posts/index")
      flash[:alert] = "権限がありません"
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
    @post = Post.find_by(:id => params[:id])
  end
end

