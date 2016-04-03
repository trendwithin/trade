require "test_helper"

feature "Collection of User Chirps Renders" do
  scenario "User clicks another Username on Timeline" do
    logged_in_as users(:shane)
    visit chirps_timeline_path
    id = chirps(:chirp).id
    email = chirps(:chirp).user.email
    within "#chirp_#{id}" do
      click_link "#{email}"
    end
    page.must_have_text chirps(:chirp).content
    page.must_have_text "Bio:"
    page.current_path == "/users/profile/#{users(:admin_user).id}"
  end
end
