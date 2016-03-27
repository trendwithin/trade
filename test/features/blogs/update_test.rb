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

  scenario 'Admin User Updates a Blog to Public/Published' do
    logged_in_as users(:admin_user)
    click_link 'New Blog'
    fill_in 'Title', with: 'This will become public and published after update'
    fill_in 'Body', with: 'After Saving I will make this public'
    click_button 'Create Blog'
    click_link 'Log out'
    click_link 'Blog'
    page.wont_have_text 'This will become public and published after update'
    page.wont_have_text 'After Saving I will make this public'
    logged_in_as users(:admin_user)
    visit blogs_path
    elem = first(:xpath, '//h3').text
    assert_equal elem, 'This will become public and published after update'
    first('.btn').click_link('Edit')
    page.check('blog[statuses]')
    page.check('blog[publishes]')
    click_button 'Update'
    click_link 'Log out'
    click_link 'Blog'
    page.must_have_text 'This will become public and published after update'
    page.must_have_text 'After Saving I will make this public'
  end
end
