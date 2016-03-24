require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:yml_user)
  end

  test 'user valid?' do
    assert @user.valid?
  end

  test 'maximum legnth of email' do
    @user.email = 'a' * 244 + '@example.com'
    assert @user.valid?
  end

  test 'emails greater than 256 not valid' do
    @user.email = 'a' * 245 + '@example.com'
    refute @user.valid?
  end

  test 'validates uniquness of email' do
    same_email = @user.dup
    refute same_email.valid?
  end

  test 'username under 20 characters' do
    @user.username = 'a' * 20
    assert @user.valid?
  end

  test 'username > 20 characters' do
    @user.username = "a" * 21
    refute @user.valid?
  end

  test 'first name under 20 characters' do
    @user.first_name = 'a' * 20
    assert @user.valid?
  end

  test 'first name > 20 characters not valid' do
    @user.first_name = 'a' * 21
    refute @user.valid?
  end

  test 'last name under 20 characters' do
    @user.last_name = 'a' * 20
    assert @user.valid?
  end

  test 'last name > 20 characters not valid' do
    @user.last_name = 'a' * 21
    refute @user.valid?
  end

  test 'website < 50 characters' do
    @user.website = 'a' * 50
    assert @user.valid?
  end

  test 'website > 50 characters not valid' do
    @user.website = 'a' * 51
    refute @user.valid?
  end

  test 'location under 50 characters' do
    @user.location = 'a' * 50
    assert @user.valid?
  end

  test 'location > 50 characters invalid' do
    @user.location = 'a' * 51
    refute @user.valid?
  end

  test 'user bio under 1000 characters' do
    @user.bio = 'a' * 1000
    assert @user.valid?
  end

  test 'user bio > 1000 characters' do
    @user.bio ='a' * 1001
    refute @user.valid?
  end
end
