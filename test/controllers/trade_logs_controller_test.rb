require "test_helper"

class TradeLogsControllerTest < ActionController::TestCase
  def trade_log
    @trade_log ||= trade_logs :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_logs)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("TradeLog.count") do
      post :create, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_one_shares: trade_log.exit_one_shares, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_three_shares: trade_log.exit_three_shares, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, exit_two_shares: trade_log.exit_two_shares, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    end

    assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  def test_show
    get :show, id: trade_log
    assert_response :success
  end

  def test_edit
    get :edit, id: trade_log
    assert_response :success
  end

  def test_update
    put :update, id: trade_log, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_one_shares: trade_log.exit_one_shares, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_three_shares: trade_log.exit_three_shares, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, exit_two_shares: trade_log.exit_two_shares, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, target: trade_log.target, trade_opened_at: trade_log.trade_opened_at, user_id: trade_log.user_id }
    assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  def test_destroy
    assert_difference("TradeLog.count", -1) do
      delete :destroy, id: trade_log
    end

    assert_redirected_to trade_logs_path
  end
end
