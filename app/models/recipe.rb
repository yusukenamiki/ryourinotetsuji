class Recipe < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 2200 }
  validates :image, presence: { message: 'を選択してください。' }, file_size: { less_than: 5.megabytes }

  attachment :image, type: :image
end
