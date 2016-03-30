module TradeLogsHelper
  def weighted_avg trade_log
    total_shares = trade_log.position_size
    entry = trade_log.entry_price
    if trade_log.exit_one_shares && trade_log.exit_one_price
      exit_one_shares = trade_log.exit_one_shares.to_f
      exit_one_price = trade_log.exit_one_price
      first_weight = exit_one_shares / total_shares
      first_exit_avg = (exit_one_price - entry) / entry * 100
    else
      first_weight, first_exit_avg = 0, 0
    end
    if trade_log.exit_two_shares && trade_log.exit_two_price
      second_exit_size = trade_log.exit_two_shares.to_f
      second_exit_price = trade_log.exit_two_price
      second_weight = second_exit_size / total_shares
      second_exit_avg = (second_exit_price - entry) / entry * 100
    else
      second_weight, second_exit_avg = 0, 0
    end
    if trade_log.exit_three_shares && trade_log.exit_three_price
      third_exit_size = trade_log.exit_three_shares.to_f
      third_exit_price = trade_log.exit_three_price
      third_weight = third_exit_size / total_shares
      third_exit_avg = (third_exit_price - entry) / entry * 100
    else
      third_weight, third_exit_avg = 0, 0
    end
    ( (first_weight * first_exit_avg) + (second_weight * second_exit_avg) + (third_weight * third_exit_avg) ).floor.to_s << '%'
  end
end
