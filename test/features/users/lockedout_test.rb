require "test_helper"

feature "20 Failed Attempts Results in Locked out User" do
  before do
    ActionMailer::Base.deliveries.clear
    @locked_user = User.new(email: 'locked_user@example.com', password: 'password', password_confirmation: 'password')
    @locked_user.confirm
    @locked_user.save
  end
  scenario 'Reset Account After Lockout' do
    visit new_user_session_path
    20.times do
      fill_in 'user_login', with: @locked_user.email
      fill_in 'Password', with: 'password123'
      click_button 'Log in'
      @locked_user.reload
    end
    assert_equal 20, @locked_user.failed_attempts
    fill_in 'user_login', with: @locked_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_content 'Your account is locked.'
    visit new_user_unlock_path
    click_button "Resend unlock instructions"
    token = token = ActionMailer::Base.deliveries[0].body.decoded.match(/unlock_token=([^"]+)/)[1]
    visit user_unlock_path(unlock_token: token)
    page.must_have_text 'Your account has been unlocked successfully. Please sign in to continue.'
    fill_in 'user_login', with: @locked_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_text "Signed in successfully."
  end
end
