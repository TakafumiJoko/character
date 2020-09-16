class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  has_one_attached :image
  
  validates :image_url, presence: true
  validates :origin, presence: true, length: { is: 1 }
  validates :stroke_count, presence: true
  validates :user_id, presence: true
  
  default_scope -> { order(created_at: :desc) }
end
