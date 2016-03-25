class Blog < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 3000 }
  validates :user_id, presence: true
end
