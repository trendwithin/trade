require "test_helper"

feature "Create Chirp on the Main Timeline" do
  scenario "Registered User Creates a New Chirp" do
    logged_in_as users(:shane)
    visit timeline_chirps_path
    fill_in 'chirp[content]', with: 'Adding A New Chirp'
    click_button 'Create Chirp'
    page.must_have_content 'Adding A New Chirp'
    page.must_have_content 'Comment was successfully added.'
  end

  scenario 'Registered User Submits Empty Chirp' do
    logged_in_as users(:shane)
    visit timeline_chirps_path
    click_button 'Create Chirp'
    page.must_have_content "Content can't be blank"
    page.current_path == timeline_chirps_path
  end

  scenario 'Registerd User Submits Chirp > 1000 Characters' do
    logged_in_as users(:shane)
    visit timeline_chirps_path
    content = 'a' * 1001
    fill_in 'chirp[content]', with: content
    click_button 'Create Chirp'
    page.must_have_content "Content is too long (maximum is 1000 characters)"
  end
end
