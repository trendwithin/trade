require "test_helper"

class ChirpsHelperTest < ActionView::TestCase
  def setup
    @chirp_helper = User.new(email: 'chirp_helper@example.com', password: 'password')
    @chirp_helper.confirm
    @chirp_helper.save
  end

  test '#to_name returns email when username empty' do
    assert_equal @chirp_helper.email, to_name(@chirp_helper)
  end

  test '#to_name returns username when present' do
    @chirp_helper.username = 'Oriole'
    assert_equal 'Oriole', to_name(@chirp_helper)
  end
end
