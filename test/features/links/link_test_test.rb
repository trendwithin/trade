require "test_helper"

feature "Admin Link Test" do
  scenario "Nav Bar Links After Admin User Login" do
    logged_in_as users(:admin_user)
    page.must_have_link 'New Blog'
    click_link 'New Blog'
    page.must_have_content 'New Blog'
    page.must_have_content 'Title'
    page.must_have_content 'Body'


    page.must_have_link 'Profile'
    click_link 'Profile'
    page.must_have_text 'Account Overview'

    page.must_have_link 'Blog'
    click_link 'Blog'
    page.must_have_text blogs(:first_blog_post).body

    page.must_have_link 'Log out'
    click_link 'Log out'
    page.must_have_text 'Signed out successfully.'
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
