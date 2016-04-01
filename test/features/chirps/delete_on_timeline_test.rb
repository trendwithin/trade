require "test_helper"

feature "Deletion of Chirps From TimeLine" do
  scenario "Admin User Deletes a Chirp" do
    logged_in_as users(:admin_user)
    visit timeline_chirps_path
    fill_in 'chirp[content]', with: 'This is offensive'
    click_button 'Create Chirp'
    page.must_have_text "This is offensive"
    id = Chirp.find_by(content: 'This is offensive').id
    within("#chirp_#{id}") do
      click_link 'Delete'
    end
    page.wont_have_text 'This is offensive'
    page.must_have_text 'Comment was successfully deleted.'
  end

  scenario "Non-Admin Users Will Not Be Shown Delete Link" do
    logged_in_as users(:shane)
    visit timeline_chirps_path
    page.wont_have_link 'Delete'
  end
end
