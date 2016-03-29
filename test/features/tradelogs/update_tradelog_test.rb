require "test_helper"

feature "Admin User Updates Trade Log" do
  scenario "Admin Updates and Exiting Trade Log to Profide New Information", :js => true do
    logged_in_as users(:admin_user)
    visit trade_log_path(trade_logs(:minimal_trade))
    click_link 'Edit'
    fill_in 'trade_log[exit_two_shares]', with: 25
    fill_in 'trade_log[exit_two_price]', with: 21.00
    page.execute_script("$('#second_exit').datepicker('setDate', '02/01/2016')")
    sleep(1)
    click_button 'Update Trade log'
    page.must_have_text 'Trade log was successfully updated.'
  end
end
