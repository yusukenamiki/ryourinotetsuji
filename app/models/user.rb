class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :username, presence: true

  def self.guest
    find_or_create_by(username: "ゲストユーザー", email: 'guestuser@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
