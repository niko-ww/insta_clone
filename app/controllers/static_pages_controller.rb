class StaticPagesController < ApplicationController
  
  def top
    if user_signed_in?
      if params[:q]
        relation = Post.joins(:user)
        @feed_items = relation.merge(User.search_by_keyword(params[:q]))
                        .or(relation.search_by_keyword(params[:q]))
                        .page(params[:page]).per(9)
      else
        @feed_items = current_user.feed.page(params[:page]).per(9)
      end
    end
  end
  
  def riyo_kiyaku
  end
end
