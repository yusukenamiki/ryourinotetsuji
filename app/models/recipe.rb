class Recipe < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :body
    validates :image, presence: { message: 'を選択してください。' }, file_size: { less_than: 5.megabytes }
  end

  attachment :image, type: :image
end
