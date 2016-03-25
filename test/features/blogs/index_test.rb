require "test_helper"

feature "Blog Index Shows All Published Post To Users" do
  scenario "User Visits Blog Post Index" do
    logged_in_as users(:shane)
    visit blogs_path
    page.assert_selector('.post', count: 8)
  end
end

feature 'Index Shows All Available Post To Admin' do
  scenario 'Admin Views Blog Post Index' do
    logged_in_as users(:admin_user)
    visit blogs_path
    page.assert_selector('.post', count: 10)
  end
end

feature 'Public Published Post Available to Guest Visitors to Site Root' do
  scenario 'When a Guest at Root Clicks Blogs, then Pub Pub viewable' do
    visit root_path
    click_link 'Blog'
    page.assert_selector('.post', 4)
  end
end
