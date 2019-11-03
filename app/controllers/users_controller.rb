class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,    only: [:edit_password, :update_password]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(9)
  end

  def edit_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "パスワードを更新しました"
      redirect_to @user
    else
      render 'edit_password'
    end
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

  def favorites
    @user = User.find(params[:id])
    @favposts = @user.favposts.page(params[:page]).per(9)
  end

  private

    def user_params
      params.require(:user).permit(:password,:password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
