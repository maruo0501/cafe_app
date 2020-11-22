class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :favorites, :comments]
  before_action :set_posts

  def show
    @favorite_posts = @user.favorite_posts
    @comment_posts = @user.comment_posts
  end

  def favorites
    @favorite_posts = @user.favorite_posts
  end

  def comments
    @comment_posts = @user.comment_posts
  end

  private
  def set_user
    @user = User.find_by(:id => params[:id])
  end

  def set_posts
    @posts = @user.posts
  end
end
