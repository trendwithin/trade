require "test_helper"

feature "Admin User Creates A New Blog Post" do
  before do
    logged_in_as users(:admin_user)
  end
  scenario "Title and Body Filled Out With Valid Data" do
    click_link 'New Blog'
    fill_in 'Title', with: 'This is a new blog'
    fill_in 'Body', with: 'This is a new blog body'
    click_button 'Create Blog'
    page.must_have_text 'Blog was successfully created.'
    page.must_have_text 'This is a new blog'
    page.must_have_text 'This is a new blog body'
  end

  scenario 'Title and Body Exceed Length' do
    visit new_blog_path
    title = 'a' * 51
    body = 'a' * 3001
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_button 'Create Blog'
    page.must_have_text 'Title is too long (maximum is 50 characters)'
    page.must_have_text 'Body is too long (maximum is 3000 characters)'
  end

  scenario 'Title and Body Empty' do
    visit new_blog_path
    click_button 'Create Blog'
    page.must_have_text "Title can't be blank"
    page.must_have_text "Body can't be blank"
  end
end
