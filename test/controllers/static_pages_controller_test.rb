require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get test" do
    get :home
    assert_response :success
  end

end
