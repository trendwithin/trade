require "test_helper"

feature "Admin User Updates Post" do
  scenario "Admin User Edits an Existing Post" do
    logged_in_as users(:admin_user)
    visit blogs_path
    elem = first(:xpath, '//h3').text
    first('.btn').click_link('Edit')
    fill_in 'Title', with: 'Editing This Title'
    click_button 'Update'
    page.must_have_text 'Blog was successfully updated.'
    page.must_have_text 'Editing This Title'
    page.wont_have_text elem
  end
end
