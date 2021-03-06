class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.page(params[:page]).per(15).order(created_at: 'DESC')
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def search
    @user_or_post = params[:option]
    if @user_or_post == "1"
      @users = User.search(params[:search], @user_or_post).page(params[:page]).per(20)
    else
      @posts = Post.search(params[:search], @user_or_post).page(params[:page]).per(20)
    end
  end
end
