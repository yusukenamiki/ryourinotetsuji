class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  validates :username, presence: true

  attachment :profile_image

  def self.guest
    find_or_create_by(username: "ゲストユーザー", email: 'guestuser@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def already_favorited?(recipe)
    self.favorites.exists?(recipe_id: recipe.id)
  end
end
