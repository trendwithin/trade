require "test_helper"

feature "Registered Users Can Comment on A Post" do
  scenario "User Fill in Comment Form with Valid Data" do
    logged_in_as users(:shane)
    visit blog_path blogs(:first_blog_post)
    fill_in 'comment[body]', with: 'I am adding a comment from Create_Comment_Test'
    click_button 'Create Comment'
    page.must_have_text 'Comment successfully submited'
    click_link 'Log out'
    logged_in_as users(:admin_user)
    visit blog_path blogs(:first_blog_post)
    fill_in 'comment[body]', with: 'I am responding from Create_Comment_Test'
    click_button 'Create Comment'
    page.must_have_text 'Comment successfully submited'
    page.must_have_text 'I am adding a comment from Create_Comment_Test'
    page.must_have_text 'I am responding from Create_Comment_Test'
  end
end

feature 'UHP: Malformed Data Prevents Comment Validating' do
  scenario 'User submits a blank comment' do
    logged_in_as users(:shane)
    visit blog_path blogs(:first_blog_post)
    click_button 'Create Comment'
    page.must_have_text "Body can't be blank"
  end

  scenario 'User submits comment exceeding length validation' do
    logged_in_as users(:shane)
    visit blog_path blogs(:first_blog_post)
    body = 'a' * 1001
    fill_in 'comment[body]', with: body
    click_button 'Create Comment'
    page.must_have_text 'Body is too long (maximum is 1000 characters)'
  end
end
