require "test_helper"

feature "Updating an Existing Chirp" do
  scenario "Admin Edits A Chirp" do
    logged_in_as users(:admin_user)
    visit timeline_chirps_path
    id = chirps(:chirptwo).id
    content = chirps(:chirptwo).content
    within("#chirp_#{id}") do
      click_link 'Edit'
    end
    fill_in 'chirp[content]', with: 'Updating Chirp Two'
    click_button 'Update Chirp'
    page.must_have_text 'Updating Chirp Two'
    page.wont_have_text content
  end

  scenario 'Edit Not Shown to Registered Users' do
    logged_in_as users(:shane)
    visit timeline_chirps_path
    page.wont_have_link 'Edit'
  end
end
