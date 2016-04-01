class Chirp < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  scope :desc, -> { order(created_at: :desc) }
end
