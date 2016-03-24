require "test_helper"

feature "User Sign In" do
  def setup
    @new_user = User.new(email: 'sign_in_test@example.com', password: 'password', password_confirmation: 'password')
    @new_user.confirm
    @new_user.save
  end

  scenario 'Valid User with Valid Credentials Logs In' do
    visit root_path
    click_link 'Log in'
    fill_in 'user_login', with: @new_user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_text 'Signed in successfully.'
    page.must_have_text 'This is a dummy page to test against.'
  end

  scenario 'Valid User Enters Empty Form' do
    visit new_user_session_path
    click_button 'Log in'
    page.must_have_text "Invalid login or password."
    page.wont_have_text "This is a dummy page to test against."
  end

  scenario 'Navbar Links Modify- Log out and Profile Added' do
    visit new_user_session_path
    logged_in_as @new_user
    page.must_have_link 'Log out'
    page.must_have_link 'Profile'
    page.wont_have_link 'Sign up'
    page.wont_have_link 'Sign up'
  end
end
