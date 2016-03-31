require "test_helper"

class ChirpTest < ActiveSupport::TestCase
  def setup
    @user = users(:shane)
    @chirp = @user.chirps.build(content: 'Bacon Lorem')
  end

  test 'empty chirp does not validate' do
    @chirp.content = ''
    refute @chirp.valid?
  end

  test 'maximum length of chirp 1000 characters' do
    @chirp.content = 'a' * 1000
    assert @chirp.valid?
  end

  test 'chrip length over 1000 characters' do
    @chirp.content = 'a' * 1001
    refute @chirp.valid?
  end

  test 'chirp association to user' do
    @chirp.user_id = nil
    refute @chirp.valid?
  end

  test 'DESC order of chirps' do
    assert_equal chirps(:chirptwo), Chirp.desc.first
  end

end
