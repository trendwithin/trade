require "test_helper"

feature "User Profile Page" do
  before do
    @new_user = User.new(email: 'new_user@example.com', password: 'password', password_confirmation: 'password')
    @new_user.confirm
    @new_user.save
  end

  scenario "New User Lacks Username in Profile" do
    logged_in_as @new_user
    click_link 'Profile'
    page.wont_have_text 'Added Username'
  end

  scenario "New User Adds Username to Profile" do
    logged_in_as @new_user
    click_link 'Profile'
    click_link 'Edit'
    page.must_have_text 'Account Overview'
    fill_in 'Username', with: 'Added Username'
    fill_in 'user_current_password', with: 'password'
    click_button 'Update'
    page.must_have_text 'Your account has been updated successfully.'
    visit users_show_path
    page.must_have_text 'Added Username'
  end

  scenario "User Adds A Bio to Their Profile" do
    logged_in_as @new_user
    visit edit_user_registration_path
    fill_in 'user_bio', with: 'I am adding a new bio'
    fill_in 'user_current_password', with: 'password'
    click_button 'Update'
    page.must_have_text 'Your account has been updated successfully.'
    visit users_show_path
    page.must_have_text 'I am adding a new bio'
  end

  scenario 'User Adds Name, Location, Website to Bio' do
    logged_in_as @new_user
    visit edit_user_registration_path
    fill_in 'user_first_name', with: 'Vic'
    fill_in 'user_last_name', with: 'Mackey'
    fill_in 'user_location', with: 'South Central'
    fill_in 'user_website', with: 'theshield.net'
    fill_in 'user_current_password', with: 'password'
    click_button 'Update'
    page.must_have_text 'Your account has been updated successfully.'
    visit users_show_path
    page.must_have_text 'Vic'
    page.must_have_text 'Mackey'
    page.must_have_text 'South Central'
    page.must_have_text 'theshield.net'
  end

  scenario 'User Attempts to Change Email to an Existing One' do
    logged_in_as @new_user
    visit edit_user_registration_path
    fill_in 'user_email', with: users(:yml_user).email
    fill_in 'user_current_password', with: 'password'
    click_button 'Update'
    page.must_have_text 'Email has already been taken'
  end
end
