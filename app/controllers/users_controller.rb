class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:mypage, :edit, :update]
  # before_action :set_user, only: [:show, :edit, :update]
  # before_action :authenticate_user!, only: [:mypage]
  before_action :set_user, only: [:show]

  # def mypage
  #   redirect_to user_path(current_user)
  # end
  
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

  # def user_params
  #   params.fetch(:user, {}).permit(:name)
  # end
end
