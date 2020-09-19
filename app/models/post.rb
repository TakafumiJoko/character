class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  has_one_attached :image
  
  validates :image_url, presence: true
  validates :origin, presence: true, length: { is: 1 }
  validates :stroke_count, presence: true
  validates :user_id, presence: true
  
  default_scope -> { order(created_at: :desc) }
  
  ransacker :comments_count do
    query = '(SELECT COUNT (*) FROM comments WHERE comments.post_id = posts.id GROUP BY comments.post_id ORDER BY COUNT (*) DESC)'
    Arel.sql(query)
  end
end
