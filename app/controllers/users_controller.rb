class UsersController < ApplicationController
  before_action :authenticate_user!, 
                  only: [:show, :following, :followers]

  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(9)
  end

  def following
    @title = "フォローの一覧"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(15)
    render 'show_follow'
  end

  def followers
    @title = "フォロワーの一覧"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(15)
    render 'show_follow'
  end
end
