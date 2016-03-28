require "test_helper"

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def comment
    @comment ||= comments(:first_comment)
  end

  test 'posting comment without registration prohibited' do
    refute_difference('Comment.count') do
      post :create, { blog_id: blogs(:first_blog_post), comment: { body: comment.body} }
    end
  end

  test 'deleting of comment without registraion prohibited' do
    refute_difference('Comment.count', -1) do
      delete :destroy, id: comment, blog_id: comment.blog_id
    end
  end

  test 'updating of comment without registration prohibited' do
    put :update, blog_id: blogs(:first_blog_post), id: comment, comment: { body: 'test'}
    assert_response 302
  end

  test 'comment deletion by users prohibited' do
    sign_in users(:shane)
    count = Comment.all.count
    refute_difference('Comment.count', -1) do
      delete :destroy, id: comment, blog_id: comment.blog_id
    end
  end

  test 'updating comment by users prohibited' do
    put :update, blog_id: blogs(:first_blog_post), id: comment, comment: { body: 'test'}
    assert_response 302
  end
end
