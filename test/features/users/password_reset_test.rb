require "test_helper"

class PasswordResetTest < Capybara::Rails::TestCase
  feature 'User Forgets Their Password' do
    before do
      ActionMailer::Base.deliveries.clear
      @forgot = User.new(email: 'forgot_test@example.com', password: 'password', password_confirmation: 'password_confirmation')
      @forgot.confirm
      @forgot.save
    end

   scenario 'User Clicks Link to Reset Password' do
     visit new_user_session_path
     click_link 'Forgot your password?'
     fill_in 'Email', with: @forgot.email
     assert_difference('ActionMailer::Base.deliveries.count', 1) do
       click_button "Send me reset password instructions"
       token = token = ActionMailer::Base.deliveries[0].body.decoded.match(/password_token=([^"]+)/)[1]
       visit edit_user_password_path(reset_password_token: token)
       fill_in 'New password', with: 'newpassword'
       fill_in 'Confirm new password', with: 'newpassword'
       click_button 'Change my password'
       page.must_have_text "Your password has been changed successfully. You are now signed in."
     end
   end
 end
end
