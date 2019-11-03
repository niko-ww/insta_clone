class Comment < ApplicationRecord 
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  validates :text, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true
end
