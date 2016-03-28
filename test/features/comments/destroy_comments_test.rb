require "test_helper"

feature "Admin User Deletes A Comment" do
  scenario "Admin User Clicks Delete on A Comment" do
    logged_in_as users(:admin_user)
    visit blog_path blogs(:first_blog_post)
    id = comments(:inappropriate_comment).id
    comment = comments(:inappropriate_comment).body
    within("#comment_#{id}") do
      click_link 'Delete'
    end
    visit blog_path(:first_blog_post)
    page.wont_have_text comment
  end
end
