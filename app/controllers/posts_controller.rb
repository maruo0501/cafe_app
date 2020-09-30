class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def update
    # @post = params[:store_name][:content][:image]
    @post = Post.find_by(id: params[:id])
    # @post.store_name = params[:store_name]
    # @post.content = params[:content]
    # @post.image = params[:image]
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

  # private
  def post_params
    params.permit(:store_name, :content, :image, :authenticity_token, :commit, :wifi, :power, :creditcard)
  end
  def update_params
    params.require(:post).permit(:store_name, :content, :image, :_method, :authenticity_token, :commit, :id)
  end
end

