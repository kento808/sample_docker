class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user,       only: :destroy

  def index
    @posts = current_user.liked_posts.page(params[:page]).per(20)
  end

  def new
    @post = current_user.posts.build if user_signed_in?
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])
    if @post.save
      flash[:success] = "投稿しました！"
      redirect_to post_path(@post)
    else
      @feed_items = current_user.feed.page(params[:page])
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:info] = "削除しました。"
    redirect_to request.referrer || root_url
  end

  private
    def post_params
      params.require(:post).permit(:content, :image)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
