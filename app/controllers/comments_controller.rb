class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
    # @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントを作成しました"
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      flash[:notice] = "コメントを作成できませんでした"
      redirect_back(fallback_location: root_path)  #同上
    end
  end

  def destroy
    # post = Post.find(params[:post_id])
    # @comment = post.comments.find(params[:id])
    # @comment.destroy
    # redirect_back(fallback_location: root_path)
    @comment.destroy
    flash[:notice] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end

#   def create
#     @post = Post.find(params[:post_id])
#     @comment = @post.comments.new(comment_params)
#     @comment.user_id = current_user.id
#     if @comment.save
#       redirect_to request.referer
#     else
#       @post_new = Book.new
#       @comments = @post.comments
#       redirect_to new_post_path
#     end
#   end

#   def destroy
#     @post = Post.find(params[:post_id])
#     @comment = Comment.find(params[:id])
#     @comment.destroy
#     redirect_to request.referer
#   end

#   private

#   def comment_params
#     params.require(:comment).permit(:comment)
#   end
# end