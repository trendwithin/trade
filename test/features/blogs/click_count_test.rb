require "test_helper"

feature "Count Click Increments on Show Clicks" do
  scenario "A User Clicks Show for A Post and Click Count Increases" do
    logged_in_as users(:shane)
    visit blogs_path
    title = first('.title').text
    click_count = Blog.find_by(title: title).click_count
    first('.meta').click_link('Read More...')
    assert_equal click_count + 1, Blog.find_by(title: title).click_count
  end
end
