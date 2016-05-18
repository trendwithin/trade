require "test_helper"

class VotableTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:shane)
    @blog = blogs(:first_blog_post)
  end

  test 'Logged in user Upvotes Once blogs#index' do
    post_via_redirect '/users/sign_in', 'user[login]' => @user.email, 'user[password]' => 'password'
    get '/blogs'
    assert_equal 0, @blog.votes.count
    assert_select "a[href=?]", blog_vote_path(@blog), text: 'Upvote:'
    post blog_vote_path(@blog)
    assert_equal 1, @blog.votes.count
    post blog_vote_path(@blog)
    assert_equal 1, @blog.votes.count
  end

  test 'Logged in user upvotes blog#show' do
    post_via_redirect '/users/sign_in', 'user[login]' => @user.email, 'user[password]' => 'password'
    get "/blogs/#{@blog.id}"
    assert_equal 0, @blog.votes.count
    assert_select "a[href=?]", blog_vote_path(@blog), text: 'Upvote:'
    post blog_vote_path(@blog)
    assert_equal 1, @blog.votes.count
  end

  test 'Vote inaccessible sans registration' do
    get root_path
    refute_difference 'Vote.count', 1 do
      post blog_vote_path(@blog)
    end
  end
end
