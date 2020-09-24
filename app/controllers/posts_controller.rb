class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @id = Post.find_by(id: params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
