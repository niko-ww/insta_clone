class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.create(text: comment_params[:text], post_id: comment_params[:post_id],user_id: current_user.id)
    post = comment.post
    post.create_notification_comment(current_user, comment.id)
    redirect_to "/posts/#{comment.post.id}" 
  end

  private
    def comment_params
      params.permit(:text, :post_id)
    end

end
