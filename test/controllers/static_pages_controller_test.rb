require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get test" do
    get :home
    assert_response :success
  end

  test 'should get dummy_page (This page is only for testing)' do
    get :dummy_page
    assert_response :success
  end
end
