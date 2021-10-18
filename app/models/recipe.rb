class Recipe < ApplicationRecord
  belongs_to :user

  attachment :image

  has_many :favorites, dependent: :destroy
  has_many :comments

  with_options presence: true do
    validates :title
    validates :body
    validates :image
  end
end
