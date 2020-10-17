class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :find_user, only: [:show, :favorites, :comments]

  def show
    @posts = @user.posts
    @favorite_posts = @user.favorite_posts
    @comment_posts = @user.comment_posts
  end

  def favorites
    @posts = @user.posts
    @favorite_posts = @user.favorite_posts
  end

  def comments
    @posts = @user.posts
    @comment_posts = @user.comment_posts
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
