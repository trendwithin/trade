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

  scenario "Admin User can Publish a Blog" do
    visit new_blog_path
    fill_in 'Title', with: 'Publish this Blog'
    fill_in 'Body', with: 'Test to verify that this blog gets published.'
    page.check('blog[publishes]')
    click_button 'Create Blog'
    visit blogs_path
    page.must_have_text 'Test to verify that this blog gets published.'
  end
end

feature "Unpublished Blog Post Not Viewable by Registered User" do
  scenario "Admin Creates Blog Post That is Not Published" do
    logged_in_as users(:admin_user)
    visit new_blog_path
    fill_in 'Title', with: 'Registered Users Will Not See Me'
    fill_in 'Body', with: 'Now you see me?'
    click_button 'Create Blog'
    click_link 'Log out'
    logged_in_as users(:shane)
    visit blogs_path
    page.wont_have_text 'Registered Users Will Not See Me'
    page.wont_have_text 'Now you see me?'
  end
end

feature "Public Blog Post Viewabe by Everyone Including Guest Visitors" do
  scenario 'Admin Creates Blog Post That Is Viewable to Site Visitors' do
    logged_in_as users(:admin_user)
    visit new_blog_path
    fill_in 'Title', with: 'Publish Blog For General Public Viewing'
    fill_in 'Body', with: 'This Post Viewable by Clicking Blog'
    page.check('blog[statuses]')
    page.check('blog[publishes]')
    count = Blog.posted.public_blog.count
    click_button 'Create Blog'
    assert_equal count + 1, Blog.posted.public_blog.count
    click_link 'Log out'
    click_link 'Blog'
    page.must_have_text 'Publish Blog For General Public Viewing'
    page.must_have_text 'This Post Viewable by Clicking Blog'
  end
end
