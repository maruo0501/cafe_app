class HomesController < ApplicationController
  before_action :post_index, :only => [:top]
  def top
  end

  def post_index
    @posts = Post.page(params[:page]).per(6).order(:created_at => :desc)
  end
end

