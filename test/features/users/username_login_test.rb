require "test_helper"

feature "Users May Sign in With Email or Username" do
  before do
    @user = User.new(email: 'test_email_login@example.com', password: 'password', password_confirmation: 'password')
    @user.confirm
    @user.username = 'testuser'
    @user.save
  end

  scenario "User Logs In With Email" do
    visit new_user_session_path
    fill_in 'user_login', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_text 'Signed in successfully.'
  end

  scenario 'User Logs In With Username' do
    visit new_user_session_path
    fill_in 'user_login', with: @user.username
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_text 'Signed in successfully.'
  end
end
