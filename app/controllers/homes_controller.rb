class HomesController < ApplicationController
  before_action :post_index, :only => [:top]
  def top
  end

  def post_index
    @posts = Post.includes([:user]).page(params[:page]).per(6).order(:created_at => :desc) # 編集後
  end
end



