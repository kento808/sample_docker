class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.liked_posts.page(params[:page]).per(20)
  end

  def create
    @post = Post.find(params[:post_id])
    unless @post.favorlit?(current_user)
      @post.favorlit(current_user)
      @post.create_notification_like!(current_user)
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.favorlit?(current_user)
      @post.unfavorlit(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
