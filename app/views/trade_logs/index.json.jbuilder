json.array!(@trade_logs) do |trade_log|
  json.extract! trade_log, :id, :user_id, :trade_opened_at, :symbol, :position_size, :entry_price, :stop, :target, :exit_one_on, :exit_one_shares, :exit_one_price, :exit_two_on, :exit_two_shares, :exit_two_price, :exit_three_on, :exit_three_shares, :exit_three_price
  json.url trade_log_url(trade_log, format: :json)
end
