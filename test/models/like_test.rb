require "test_helper"

class LikeTest < ActiveSupport::TestCase
  def like
    @like ||= Like.new
  end

  def test_valid
    assert like.valid?
  end
end
