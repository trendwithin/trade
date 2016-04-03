require "test_helper"

feature "Upvote Clicks" do
  scenario "A User can Like a Chirp" do
    logged_in_as users(:shane)
    visit chirps_timeline_path
    id = chirps(:chirptwo).id
    content = chirps(:chirptwo).content
    likes = chirps(:chirptwo).likes.count
    within("#chirp_#{id}") do
      click_link 'Upvote'
    end
    within("#chirp_#{id}") do
      page.must_have_text "Upvote: #{likes + 1}"
    end
  end
end
