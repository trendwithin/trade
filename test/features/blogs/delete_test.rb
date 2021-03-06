require "test_helper"

feature "Admin User Can Delete" do
  scenario "Adming User Clicks Delete for A Post" do
    logged_in_as users(:admin_user)
    visit blogs_path
    elem = first(:xpath, '//h3').text
    first('.tags').click_link('Delete')
    page.must_have_text 'Blog was successfully destroyed.'
  end
end
