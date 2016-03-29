require "test_helper"

feature "Admin User Creates New Trade Log" do
  scenario "Minimal Data for Valid Trade", :js => true do
    logged_in_as users(:admin_user)
    visit new_trade_log_path
    page.execute_script("$('.datepicker').datepicker('setDate', '01/01/2010')")
    fill_in 'trade_log[symbol]', with: 'XYZ'
    fill_in 'trade_log[entry_price]', with: 20.23
    fill_in 'trade_log[position_size]', with: 100
    fill_in 'trade_log[stop]', with: 99
    click_button 'Create Trade log'
    page.must_have_text 'Trade log was successfully created.'
  end

  scenario "Minimal Data and One Trade Exit", :js=> true do
    logged_in_as users(:admin_user)
    visit new_trade_log_path
    page.execute_script("$('.datepicker').datepicker('setDate', '01/01/2020')")
    fill_in 'trade_log[symbol]', with: 'XYZ'
    fill_in 'trade_log[entry_price]', with: 20.23
    fill_in 'trade_log[position_size]', with: 100
    fill_in 'trade_log[stop]', with: 19
    page.execute_script("$('#first_exit').datepicker('setDate', '01/02/2020')")
    fill_in 'trade_log[exit_one_shares]', with: 25
    fill_in 'trade_log[exit_one_price]', with: 21.00
    click_button 'Create Trade log'
    page.must_have_text 'Trade log was successfully created.'
  end

  scenario 'Entry, First Exit and Second Exit Completed Form', :js=> true do
    logged_in_as users(:admin_user)
    visit new_trade_log_path
    page.execute_script("$('.datepicker').datepicker('setDate', '01/01/2020')")
    fill_in 'trade_log[symbol]', with: 'XYZ'
    fill_in 'trade_log[entry_price]', with: 20.23
    fill_in 'trade_log[position_size]', with: 100
    fill_in 'trade_log[stop]', with: 19
    page.execute_script("$('#first_exit').datepicker('setDate', '01/02/2020')")
    fill_in 'trade_log[exit_one_shares]', with: 25
    fill_in 'trade_log[exit_one_price]', with: 21.00
    page.execute_script("$('#second_exit').datepicker('setDate', '02/02/2020')")
    fill_in 'trade_log[exit_two_shares]', with: 25
    fill_in 'trade_log[exit_two_price]', with: 22.00
    click_button 'Create Trade log'
    page.must_have_text 'Trade log was successfully created.'
  end

  scenario 'Full Trade Log Form', :js=> true do
    logged_in_as users(:admin_user)
    visit new_trade_log_path
    page.execute_script("$('.datepicker').datepicker('setDate', '01/01/2020')")
    fill_in 'trade_log[symbol]', with: 'XYZ'
    fill_in 'trade_log[entry_price]', with: 20.23
    fill_in 'trade_log[position_size]', with: 100
    fill_in 'trade_log[stop]', with: 19
    page.execute_script("$('#first_exit').datepicker('setDate', '01/02/2020')")
    fill_in 'trade_log[exit_one_shares]', with: 25
    fill_in 'trade_log[exit_one_price]', with: 21.00
    page.execute_script("$('#second_exit').datepicker('setDate', '02/02/2020')")
    fill_in 'trade_log[exit_two_shares]', with: 25
    fill_in 'trade_log[exit_two_price]', with: 22.00
    page.execute_script("$('#thrid_exit').datepicker('setDate', '02/02/2020')")
    fill_in 'trade_log[exit_three_shares]', with: 25
    fill_in 'trade_log[exit_three_price]', with: 23.00
    click_button 'Create Trade log'
    page.must_have_text 'Trade log was successfully created.'
  end
end

feature "UHP: Admin Fills Out Trade Log Form Incorrectly" do
  scenario "Empty Form" do
    logged_in_as users(:admin_user)
    visit new_trade_log_path
    click_button 'Create Trade log'
    page.must_have_text '4 errors prohibited this blog from being saved:'
  end
end
