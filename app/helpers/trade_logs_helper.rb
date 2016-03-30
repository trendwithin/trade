module TradeLogsHelper
  def weighted_avg trade_log
    entry = trade_log.entry_price
    total_shares = trade_log.position_size
    first_avg = calculate_avg(entry, trade_log.exit_one_price, total_shares, trade_log.exit_one_shares)
    second_avg = calculate_avg(entry, trade_log.exit_two_price, total_shares, trade_log.exit_two_shares)
    third_avg = calculate_avg(entry, trade_log.exit_three_price, total_shares, trade_log.exit_three_shares)
    (first_avg + second_avg + third_avg).floor.to_s << '%'
  end

  def calculate_avg entry, exit_price, shares, exit_shares
    return 0 if exit_price.nil? || exit_shares.nil?
    weight = exit_shares.to_f / shares
    avg = (exit_price - entry) / entry * 100
    weight * avg
  end
end
