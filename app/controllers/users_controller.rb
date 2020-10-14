class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @favorite_posts = @user.favorite_posts
    @comment_posts = @user.comment_posts
  end

  def favorites
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @favorite_posts = @user.favorite_posts
  end

  def comments
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    @comment_posts = @user.comment_posts
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
