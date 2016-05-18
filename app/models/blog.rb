class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, as: :votable

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 3000 }
  validates :user_id, presence: true

  alias_attribute :publishes, :published
  alias_attribute :statuses, :status
  enum statuses: { pay_wall_blog: 0, public_blog: 1 }
  enum publishes: { stashed: 0, posted: 1}

  scope :most_viewed, -> { order("blogs.click_count DESC").limit(5) }
  scope :desc, -> { order ("blogs.created_at DESC") }
end
