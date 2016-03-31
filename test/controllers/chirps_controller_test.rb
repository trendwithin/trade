require "test_helper"

class ChirpsControllerTest < ActionController::TestCase
  def test_timeline
    get :timeline
    assert_response :success
  end

end
