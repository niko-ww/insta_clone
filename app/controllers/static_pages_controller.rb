class StaticPagesController < ApplicationController
  
  def top
    if user_signed_in?
      @feed_items = current_user.feed.page(params[:page]).per(9)
    end
  end
  
  def riyou_kiyaku
  end
end
