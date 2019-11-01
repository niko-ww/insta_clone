class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  
  def show
    @post = Post.find(params[:id]) 
    @comments = @post.comments.includes(:user).page(params[:page]).per(15)
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿が完了しました"
      redirect_to @post
    else
      flash.now[:alert] = "投稿が失敗しました"
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:title,:picture)
    end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
