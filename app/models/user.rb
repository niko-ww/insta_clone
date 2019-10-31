class User < ApplicationRecord
  has_many :posts, dependent: :destroy 
  has_many :active_relationships, class_name:  "Relationship",
            foreign_key: "follower_id",
            dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
            foreign_key: "followed_id",
            dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length:{maximum: 50}
  validates :username, presence: true, uniqueness: true,
            length:{maximum: 50}
  #VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  #validates :phone_number, format: { with: VALID_PHONE_REGEX, allow_nil: true}
  # :confirmable, :lockable, :timeoutable, :trackable and 
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:facebook]

  class << self
    def find_or_create_for_oauth(auth)
      find_or_create_by(email: auth.info.email) do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.username = auth.info.name
        user.email = auth.info.email
        password = Devise.friendly_token[0..5]
        logger.debug password
        user.password = password
      end
    end

    def new_with_session(params, session)
      if user_attributes = session['devise.user_attributes']
        new(user_attributes) { |user| user.attributes = params }
      else
        super
      end
    end
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                  WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
            OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    self.active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    self.following.include?(other_user)
  end

end
