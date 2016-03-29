require "test_helper"

class TradeLogTest < ActiveSupport::TestCase
  def trade_log
    @trade_log ||= trade_logs(:aapl)
  end

  # Following Fields Minimal For Valid Trade
  test 'validates presence of trade_opened_at' do
    trade_log.trade_opened_at = ''
    refute trade_log.valid?
  end

  test 'validates presence of symbol' do
    trade_log.symbol = ''
    refute trade_log.valid?
  end

  test 'validates presence of position size' do
    trade_log.position_size = ''
    refute trade_log.valid?
  end

  test 'validates presence of entry price' do
    trade_log.entry_price = ''
    refute trade_log.valid?
  end

  test 'invalidates numericality of entry price with $' do
    trade_log.entry_price = '$12.50'
    refute trade_log.valid?
  end

  test 'validates numericality of price' do
    trade_log.entry_price = 12
    assert trade_log.valid?
  end

  test 'validates numericality of first exit price' do
    trade_log.exit_one_price = 12
    assert trade_log.valid?
  end

  test 'validates numericality of first exit shares' do
    trade_log.exit_one_shares = 12
    assert trade_log.valid?
  end

  test 'invalidates float numericality of exit shares' do
    trade_log.exit_one_shares = 13.4
    refute trade_log.valid?
  end

  test 'validates numericality of second exit price' do
    trade_log.exit_two_price = 15.4
    assert trade_log.valid?
  end

  test 'validates numericality of second exit shares' do
    trade_log.exit_two_shares = 15
    assert trade_log.valid?
  end

  test 'validates numericality of third exit price' do
    trade_log.exit_three_price = 2.5
    assert trade_log.valid?
  end

  test 'validates numericality of third exit shares' do
    trade_log.exit_three_shares = 100
    assert trade_log.valid?
  end

  test 'validates numericality of stop' do
    trade_log.stop = 50
    assert trade_log.valid?
  end
end
