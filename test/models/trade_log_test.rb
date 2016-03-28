require "test_helper"

class TradeLogTest < ActiveSupport::TestCase
  def trade_log
    @trade_log ||= TradeLog.new
  end

  def test_valid
    assert trade_log.valid?
  end
end
