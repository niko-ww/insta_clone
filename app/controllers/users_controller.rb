class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show

  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(9)
  end
end
