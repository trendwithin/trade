require "test_helper"

class BlogTest < ActiveSupport::TestCase
  def blog
    @blog = blogs(:first_blog_post)
  end

  def test_valid
    assert blog.valid?
  end

  test 'presence of title' do
    blog.title = ''
    refute blog.valid?
  end

  test '50 character legnth of title' do
    blog.title = 'a' * 50
    assert blog.valid?
  end

  test '51 characters legnth title not valid' do
    blog.title = 'a' * 51
    refute blog.valid?
  end

  test '3000 character body limit' do
    blog.body = 'a' * 3000
    assert blog.valid?
  end

  test '3001 characters not valid' do
    blog.body = 'a' * 3001
    refute blog.valid?
  end

  test 'lack of presence of user' do
    blog.user_id = nil
    refute blog.valid?
  end
end
