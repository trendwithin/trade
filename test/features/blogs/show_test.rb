require "test_helper"

feature "Show Blog Post" do
  scenario "A User Clicks a Specific Blog Post on Index Renders Post" do
    logged_in_as users(:shane)
    visit blogs_path
    elem = first(:xpath, '//h3').text
    first('.meta').click_link('Read More...')
    page.must_have_text elem
    page.must_have_link 'Back'
    page.wont_have_link 'Edit'
    click_link 'Back'
    page.current_path == blogs_path
  end
end

feature 'Admin Show Blog Post' do
  scenario 'Admin User Clicks a Specific Blog Post on Index Page' do
    logged_in_as users(:admin_user)
    visit blogs_path
    elem = first(:xpath, '//h3').text
    first('.meta').click_link('Read More...')
    page.must_have_text elem
    page.must_have_link 'Edit'
    page.must_have_link 'Back'
  end
end
