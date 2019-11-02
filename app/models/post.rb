class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :users, through: :favorites
  has_many :notifications, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validates :title, presence: true
  validate  :picture_size


    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "添付ファイルのサイズ上限は5MBまでです")
      end
    end

    def create_notification_favorite(current_user)
      # すでに「お気に入り」されているか検索
      temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
      # お気に入りされていない場合のみ、通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          post_id: id,
          visited_id: user_id,
          action: 'favorite'
        )
        # 自分の投稿をお気に入りする場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

    def create_notification_comment(current_user, comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
        save_notification_comment(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
    end
  
    def save_notification_comment(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
end
