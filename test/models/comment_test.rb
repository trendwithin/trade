require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def comment
    @comment ||= Comment.new(body: 'Adding A Comment to a Blog Post')
  end

  def test_valid
    assert comment.valid?
  end

  test 'maximum characters for a comment 1000' do
    comment.body = 'a' * 1000
    assert comment.valid?
  end

  test 'edge case for comments 1001' do
    comment.body = 'a' * 1001
    refute comment.valid?
  end

  test 'presence of comment' do
    comment.body = ''
    refute comment.valid?
  end
end
