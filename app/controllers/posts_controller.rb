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
    @post = Post.new(
      content: params[:content],
      store_name: params[:store_name]
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.store_name = params[:store_name]
    @post.content = params[:content]
    if @post.save
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

  def post_params
    params.require(:post).permit(:store_name, :content, {images: []})
  end
end
