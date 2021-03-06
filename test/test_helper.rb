require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/unit'
require 'minitest/rails/capybara'
require "capybara/poltergeist"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  Capybara.javascript_driver = :poltergeist
  # Add more helper methods to be used by all tests here...

  def logged_in_as user
    email = user.email
    password = 'password'
    visit new_user_session_path
    fill_in 'user_login', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end
