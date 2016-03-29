require "test_helper"

class TradeLogsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def trade_log
    @trade_log ||= trade_logs(:aapl)
  end

  def test_index
    get :index
    assert_response 302
    assert_nil assigns(:trade_logs)
  end

  test 'index for Admin' do
    sign_in users(:admin_user)
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_logs)
  end

  test 'index for Registered' do
    sign_in users(:shane)
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_logs)
  end

  test 'new not avilable for visitor' do
    get :new
    assert_response 302
  end

  test 'new not available for Registered' do
    sign_in users(:shane)
    get :new
    assert_response 302
  end

  test 'create wil not save record without validation' do
    refute_difference("TradeLog.count") do
      post :create, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_one_shares: trade_log.exit_one_shares, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_three_shares: trade_log.exit_three_shares, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, exit_two_shares: trade_log.exit_two_shares, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, trade_opened_at: '02/02/2010', user_id: trade_log.user_id }
    end
  end

  test 'create will not save record for Registered Users' do
    sign_in users(:shane)
    refute_difference("TradeLog.count") do
      post :create, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_one_shares: trade_log.exit_one_shares, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_three_shares: trade_log.exit_three_shares, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, exit_two_shares: trade_log.exit_two_shares, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, trade_opened_at: '02/02/2010', user_id: trade_log.user_id }
    end
  end

  test 'create will work for Admin User' do
    sign_in users(:admin_user)
    assert_difference("TradeLog.count") do
      post :create, trade_log: { entry_price: trade_log.entry_price, exit_one_on: trade_log.exit_one_on, exit_one_price: trade_log.exit_one_price, exit_one_shares: trade_log.exit_one_shares, exit_three_on: trade_log.exit_three_on, exit_three_price: trade_log.exit_three_price, exit_three_shares: trade_log.exit_three_shares, exit_two_on: trade_log.exit_two_on, exit_two_price: trade_log.exit_two_price, exit_two_shares: trade_log.exit_two_shares, position_size: trade_log.position_size, stop: trade_log.stop, symbol: trade_log.symbol, trade_opened_at: '02/02/2010', user_id: trade_log.user_id }
    end
  end

  def test_show
    get :show, id: trade_log
    assert_response 302
  end

  test 'TradeLog#show unavailable to Registered' do
    sign_in users(:shane)
    get :show, id: trade_log
    assert_response 302
  end

  test 'TradeLog#show availalbe to Admin' do
    sign_in users(:admin_user)
    get :show, id: trade_log
    assert_response :success
  end

  def test_edit
    get :edit, id: trade_log
    assert_response 302
  end

  test 'TradeLog#edit unavailable for Registered' do
    sign_in users(:shane)
    get :edit, id: trade_log
    assert_response 302
  end

  def test_update
    put :update, id: trade_log, trade_log: { entry_price: trade_log.entry_price }
    assert_response 302
  end

  test 'TradeLog#update not avaliable to Registerd Users' do
    sign_in users(:shane)
    put :update, id: trade_log, trade_log: { entry_price: trade_log.entry_price }
    assert_response 302
  end

  test 'TradeLog#update available to Admin' do
    sign_in users(:admin_user)
    put :update, id: trade_log, trade_log: { entry_price: trade_log.entry_price }
      assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  test 'TradeLog#destroy not allowed non registered' do
    refute_difference("TradeLog.count") do
      delete :destroy, id: trade_log
    end
  end

  test 'TradeLog#destroy not allowed for registered' do
    sign_in users(:shane)
    refute_difference("TradeLog.count") do
      delete :destroy, id: trade_log
    end
  end

  def test_destroy_for_admin
    sign_in users(:admin_user)
    assert_difference("TradeLog.count", -1) do
      delete :destroy, id: trade_log
    end

    assert_redirected_to trade_logs_path
  end
end
