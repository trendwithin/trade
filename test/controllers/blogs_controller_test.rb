require "test_helper"

class BlogsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def blog
    @blog ||= blogs :first_blog_post
  end

  def newblog
    @new_blog ||= Blog.new(body: 'New Blog Controller Test', title: 'Controller Test', user_id: users(:admin_user).id)
  end

  def test_index_requires_subscription
    get :index
    assert_response 302
  end

  test 'Admin User Can View Blog Index Page' do
    sign_in users(:admin_user)
    get :index
    assert_response :success
  end

  test 'Registerd User Can View Blog Index Page' do
    sign_in users(:shane)
    get :index
    assert_response :success
  end

  def test_new_for_admin
    sign_in users(:admin_user)
    get :new
    assert_response :success
  end

  def test_create_allowed_for_admin_user
    sign_in users(:admin_user)
    assert_difference("Blog.count") do
      post :create, blog: { body: blog.body, click_count: blog.click_count, title: blog.title }
    end

    assert_redirected_to blog_path(assigns(:blog))
    assert_equal "Blog was successfully created.", flash[:notice]
  end

  test 'Registerd Users Not Allowed to Post Blog' do
    sign_in users(:shane)
    refute_difference('Blog.count') do
      post :create, blog: { body: blog.body, click_count: blog.click_count, title: blog.title }
      refute_equal 'Blog was successfully created.', flash[:notice]
      assert_equal 'A problem has occured.  Please email Admin if you feel this in error.', flash[:alert]
    end
  end

  test 'Blog Post Not Authorized' do
    assert_raises (NoMethodError) { post :create, blog: { body: blog.body, click_count: blog.click_count, title: blog.title } }
    refute_equal 'Blog was successfully created.', flash[:notice]
  end

  def test_show
    get :show, id: blog
    assert_response 302
  end

  test 'show for admin' do
    sign_in users(:admin_user)
    get :show, id: blog
    assert_response :success
  end

  test 'show for registered' do
    sign_in users(:shane)
    assert_response :success
  end

  def test_edit
    get :edit, id: blog
    assert_response 302
  end

  test 'Edit allowed for Admin' do
    sign_in users(:admin_user)
    get :edit, id: blog
    assert_response :success
  end

  test 'Edit not allowed for Registerd' do
    sign_in users(:shane)
    get :edit, id: blog
    assert_response 302
  end

  def test_update
    put :update, id: blog, blog: { body: 'Modified', click_count: blog.click_count, title: blog.title }
    @blog.reload
    refute_equal 'Modified', @blog.body
    assert_redirected_to root_path || request.refferer
  end

  test 'Admin can update a post' do
    sign_in users(:admin_user)
    put :update, id: blog, blog: { body: 'Modified', click_count: blog.click_count, title: blog.title }
    assert_equal "Blog was successfully updated.", flash[:notice]
    assert_redirected_to blog_path(assigns(:blog))
    @blog.reload
    assert_equal 'Modified', @blog.body
  end

  test 'Registerd user can not update a post' do
    sign_in users(:shane)
    put :update, id: blog, blog: { body: 'Modified', click_count: blog.click_count, title: blog.title }
    @blog.reload
    refute_equal 'Modified', @blog.body
    assert_redirected_to root_path || request.refferer
  end

  def test_destroy
    refute_difference("Blog.count", -1) do
      delete :destroy, id: blog
    end
    assert_redirected_to root_path || request.refferer
  end

  test 'Admin User Can Destroy A Blog Post' do
    sign_in users(:admin_user)
    assert_difference('Blog.count', -1) do
      delete :destroy, id: blog
    end
    assert_redirected_to blogs_path
  end

  test 'Registered User Can Not Destroy A Blog Post' do
    sign_in users(:shane)
    refute_difference("Blog.count", -1) do
      delete :destroy, id: blog
    end
    assert_redirected_to root_path || request.refferer
  end
end
