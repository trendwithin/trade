require "test_helper"

class VoteTest < ActiveSupport::TestCase
  def vote
    @vote ||= Vote.new
  end

  def test_valid
    assert vote.valid?
  end
end
