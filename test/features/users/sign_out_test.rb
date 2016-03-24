require "test_helper"

feature "User logs out" do
  scenario "When User Clicks Log out, Logged out of site." do
    logged_in_as users(:yml_user)
    click_link 'Log out'
    page.must_have_text 'Signed out successfully.'
  end
end
