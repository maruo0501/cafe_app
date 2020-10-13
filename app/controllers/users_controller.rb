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

# 今のところ、アカウント編集はdeviseを使う
  # def edit
  #   unless @user == current_user
  #     redirect_to user_path(@user)
  #   end
  # end

  # def update
  #   if current_user.update(user_params)
  #     redirect_to user_path(current_user)
  #   else
  #     redirect_to edit_user_path(current_user)
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # def user_params
  #   params.fetch(:user, {}).permit(:name)
  # end
end
