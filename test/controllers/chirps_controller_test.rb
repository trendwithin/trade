require "test_helper"

class ChirpsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_timeline
    get :timeline
    assert_response 302
  end

  test 'create not permissible when not signed in' do
    refute_difference('Chirp.count') do
      post :create, chirp: { content: 'not allowed' }
    end
  end

  test 'create allowed for registered user' do
    sign_in users(:shane)
    assert_difference('Chirp.count') do
      post :create, chirp: { content: 'I am allowed', user_id: users(:shane).id }
    end
  end

  test 'create allowed for admin user' do
    sign_in users(:admin_user)
    assert_difference('Chirp.count') do
      post :create, chirp: { content: 'Of course I can!', user_id: users(:admin_user).id }
    end
  end

  test 'update not permissible when not signed in' do
    content = chirps(:chirptwo).content
    put :update, id: chirps(:chirptwo), chirp: { content: 'test'}
    assert_equal content, chirps(:chirptwo).content
    assert_response 302
  end

  test 'update not permissible to registered user' do
    sign_in users(:shane)
    content = chirps(:chirptwo).content
    put :update, id: chirps(:chirptwo), chirp: { content: 'test'}
    assert_equal content, chirps(:chirptwo).content
    assert_response 302
  end

  test 'update chirp allowed for Admin user' do
    sign_in users(:admin_user)
    content = chirps(:chirptwo).content
    put :update, id: chirps(:chirptwo), chirp: { content: 'test' }
    updated = Chirp.find(chirps(:chirptwo).id)
    assert_equal 'test', updated.content
  end

  test 'delete authorization' do
    refute_difference("Chirp.count", -1) do
      delete :destroy, id: chirps(:chirptwo).id
    end
    assert_response 302
  end

  test 'delete not authorized for registered' do
    sign_in users(:shane)
    refute_difference("Chirp.count", -1) do
      delete :destroy, id: chirps(:chirptwo).id
    end
    assert_response 302
  end

  test 'delete allowed for admin' do
    sign_in users(:admin_user)
    assert_difference("Chirp.count", -1) do
      delete :destroy, id: chirps(:chirptwo).id
    end
    assert_redirected_to timeline_chirps_path
  end
end
