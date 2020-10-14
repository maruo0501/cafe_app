class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    if favorite.save!
      redirect_to posts_path
    else
      flash.now[:danger] = "お気に入りに失敗しました"
      redirect_to posts_path
    end
  end

  def destroy
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
    redirect_to posts_path
  end
end
