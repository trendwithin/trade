require "test_helper"

class TradeLogsHelperTest < ActionView::TestCase
  def setup
  @trade_log_one = trade_logs(:fake)
  @trade_log_two = trade_logs(:junk)
  @trade_log_three = trade_logs(:loss)
  @trade_log_four = trade_logs(:mix)
end

def test_weighted_aveage_returns_correct_pct_for_one_exit
  assert_equal '10%', weighted_avg(@trade_log_one)
end

def test_weighted_avg_with_multi_exit_positive_trade
  assert_equal '22%', weighted_avg(@trade_log_two)
end

def test_weighed_avg_with_negative_trade_exit
  assert_equal '-10%', weighted_avg(@trade_log_three)
end

def test_weighted_avg_with_postive_and_negative_trade_exit
  assert_equal '0%', weighted_avg(@trade_log_four)
end
end
