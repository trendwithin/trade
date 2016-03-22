require "test_helper"

feature "Users Sign Up to Site" do
  scenario "HP: User Correctly Fills in Form" do
    visit root_path
    click_link 'Sign up'
    page.must_have_text 'Sign up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    assert_difference 'ActionMailer::Base.deliveries.count', 1 do
      click_button 'Sign up'
      mail = ActionMailer::Base.deliveries
      assert_equal 'test@example.com', mail[0].to[0]
      assert_equal 'Confirmation instructions', mail[0].subject
      page.must_have_text "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
    end
  end

  scenario 'UHP: User Fills Empty Form' do
    visit new_user_registration_path
    click_button 'Sign up'
    page.must_have_text "Email can't be blank"
    page.must_have_text "Password can't be blank"
  end
end
