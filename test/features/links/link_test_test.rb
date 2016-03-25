require "test_helper"

feature "Admin Link Test" do
  scenario "Nav Bar Links for Admin User" do
    logged_in_as users(:admin_user)
    page.must_have_link 'New Blog'
    page.must_have_link 'Log out'
    page.must_have_link 'Profile'
    page.must_have_link 'Blog'
  end
end

feature 'Registered User Link Test' do
  scenario 'Nav Bar Links For Registered User' do
    logged_in_as users(:shane)
    page.must_have_link 'Blog'
    page.must_have_link 'Log out'
    page.must_have_link 'Profile'
    page.wont_have_link 'New Blog'
  end
end
