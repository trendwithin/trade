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
end
