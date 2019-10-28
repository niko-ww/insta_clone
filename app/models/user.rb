class User < ApplicationRecord
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
end
