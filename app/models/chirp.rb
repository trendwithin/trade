class Chirp < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  scope :desc, -> { order(created_at: :desc) }
end
