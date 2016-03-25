require "test_helper"

class BlogsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def blog
    @blog ||= blogs :first_blog_post
  end

  def newblog
    @new_blog ||= Blog.new(body: 'New Blog Controller Test', title: 'Controller Test', user_id: users(:admin_user).id)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    sign_in users(:admin_user)
    assert_difference("Blog.count") do
      post :create, blog: { body: blog.body, click_count: blog.click_count, title: blog.title }
    end

    assert_redirected_to blog_path(assigns(:blog))
  end

  test 'Registerd Users Not Allowed to Post Blog' do
    sign_in users(:shane)
    refute_difference('Blog.count') do
      post :create, blog: { body: blog.body, click_count: blog.click_count, title: blog.title }      
    end
  end

  def test_show
    get :show, id: blog
    assert_response :success
  end

  def test_edit
    get :edit, id: blog
    assert_response :success
  end

  def test_update
    put :update, id: blog, blog: { body: blog.body, click_count: blog.click_count, title: blog.title }
    assert_redirected_to blog_path(assigns(:blog))
  end

  def test_destroy
    assert_difference("Blog.count", -1) do
      delete :destroy, id: blog
    end

    assert_redirected_to blogs_path
  end
end
