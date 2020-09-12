class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @post    = @comment.post
    if @comment.save
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    else
        flash[:alert] = "コメントできませんでした。"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post    = @comment.post
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    else
      flash[:alert] = "コメントを削除できませんでした。"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :comment)
    end
end
