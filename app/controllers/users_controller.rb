class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :favorites, :comments, :destroy]
  before_action :set_posts

  def show
    @favorite_posts = @user.favorite_posts
    @comment_posts = @user.comment_posts
  end

  # アカウント退会
  def destroy
    @user = User.find(params[:id]) #特定のidを持つ情報を取得
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root #削除に成功すればrootページに戻る
  end

  def favorites
    @favorite_posts = @user.favorite_posts.includes([:user])
  end

  def comments
    @comment_posts = @user.comment_posts.includes([:user])
  end

  private
  def set_user
    @user = User.find_by(:id => params[:id])
  end

  def set_posts
    @posts = @user.posts
  end
end

