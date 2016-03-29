class TradeLog < ActiveRecord::Base
  belongs_to :user

  validates :trade_opened_at, presence: true
  validates :symbol, presence: true
  validates :position_size, presence: true
  validates_numericality_of :entry_price
  validates_numericality_of :exit_one_price, allow_nil: true
  validates_numericality_of :exit_two_price, allow_nil: true
  validates_numericality_of :exit_three_price, allow_nil: true
  validates_numericality_of :stop, allow_nil: true
  validates :position_size, numericality: { only_integer: true, allow_nil: true}
  validates :exit_one_shares, numericality: { only_integer: true, allow_nil: true }
  validates :exit_two_shares, numericality: { only_integer: true, allow_nil: true }
  validates :exit_three_shares, numericality: { only_integer: true, allow_nil: true }
end
