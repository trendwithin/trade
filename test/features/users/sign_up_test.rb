require "test_helper"

feature "Users Sign Up to Site" do
  before do
    ActionMailer::Base.deliveries.clear
  end

  scenario 'HP: User Sign Up w/ Confirmable Email and Log in ' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test_user_confirmable@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    assert_difference 'User.count', 1 do
      click_button 'Sign up'
      mail = ActionMailer::Base.deliveries[0]
      token = mail.body.decoded.match(/confirmation_token=([^"]+)/)[1]
      assert_equal User.find_by(email: "test_user_confirmable@example.com").confirmation_token, token
      visit "users/confirmation?confirmation_token=#{token}"
      page.must_have_text "Your email address has been successfully confirmed."
      fill_in 'user_login', with: 'test_user_confirmable@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      page.must_have_text "Signed in successfully."
    end
  end

  scenario 'HP: User Successfully Reconfirms When Token is Invalid' do
    User.create!(email: 'test_reconfirm@example.com', password: 'password', password_confirmation: 'password')
    u = User.find_by(email: 'test_reconfirm@example.com')
    u.confirmation_sent_at = 4.days.ago
    u.save
    u.reload
    token = u.confirmation_token
    visit "users/confirmation?confirmation_token=#{token}"
    click_button 'Resend confirmation instructions'
    new_token = User.find_by(email: 'test_reconfirm@example.com').confirmation_token
    visit "/users/confirmation?confirmation_token=#{new_token}"
    fill_in 'user_login', with: 'test_reconfirm@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    page.must_have_text "Signed in successfully."
  end

  scenario 'UHP: User Fills Empty Form' do
    visit new_user_registration_path
    click_button 'Sign up'
    page.must_have_text "Email can't be blank"
    page.must_have_text "Password can't be blank"
  end

  scenario 'UHP: User Fails to Timely Confirm Through Email' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test_user_confirmable@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
     u = User.find_by(email: 'test_user_confirmable@example.com')
     u.confirmation_sent_at = 4.days.ago
     u.save
     u.reload
     token = u.confirmation_token
     visit "users/confirmation?confirmation_token=#{token}"
     page.must_have_text "Email needs to be confirmed within 3 days, please request a new one"
  end

  scenario 'UHP: User Enters Data Exceeding Accepted Lengths' do
    visit new_user_registration_path
    email = 'A' * 256 + "@example.com"
    password = 'A' * 81
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign up'
    page.must_have_text '3 errors prohibited this user from being saved:'
  end

  scenario 'UHP: User enters an existing email' do
    visit new_user_registration_path
    fill_in 'Email', with: users(:yml_user).email
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    page.must_have_text 'Email has already been taken'
  end
end
