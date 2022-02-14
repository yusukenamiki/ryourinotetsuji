class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  validates :username, presence: true, length: { maximum: 30 }, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, length: { maximum: 254 }
  validates :profile, length: { maximum: 150 }
  validates :profile_image, file_size: { less_than: 2.megabytes }

  attachment :profile_image, type: :image

  def self.guest
    find_or_create_by(username: "ゲストユーザー", email: 'guestuser@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def already_favorited?(recipe)
    self.favorites.exists?(recipe_id: recipe.id)
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end
end
