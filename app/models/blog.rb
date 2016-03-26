class Blog < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 3000 }
  validates :user_id, presence: true

  enum status: { pay_wall_blog: 0, public_blog: 1 }
  enum published: { stashed: 0, posted: 1}
end
