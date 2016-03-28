require "test_helper"

feature "Admin User Can Edit A Comment" do
  scenario "Admin Edits a Comments Content" do
    logged_in_as users(:admin_user)
    visit blog_path blogs(:first_blog_post)
    id = comments(:inappropriate_comment).id
    within("#comment_#{id}") do
      click_link 'Edit'
    end
    fill_in 'comment[body]', with: 'I Edited This Comment'
    click_button 'Update Comment'
    page.must_have_text 'I Edited This Comment'
  end
end
