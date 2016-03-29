require "test_helper"

feature "Admin Can Delete TradeLog" do
  scenario "Admin clicks to Delete a TradeLog" do
    logged_in_as users(:admin_user)
    visit trade_log_path trade_logs(:minimal_trade)
    click_link 'Delete'
    page.must_have_text 'Trade log was successfully destroyed.'
    page.wont_have_text trade_logs(:minimal_trade).symbol
  end
end
