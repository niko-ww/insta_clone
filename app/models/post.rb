class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :users, through: :favorites
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validates :title, presence: true
  validate  :picture_size

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "添付ファイルのサイズ上限は5MBまでです")
    end
  end
end
