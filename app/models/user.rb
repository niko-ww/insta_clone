class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length:{maximum: 50}
  validates :username, presence: true, uniqueness: true,
            length:{maximum: 50}
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :phone_number, format: { with: VALID_PHONE_REGEX }, allow_nil: true
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
end
