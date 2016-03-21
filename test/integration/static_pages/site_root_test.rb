require "test_helper"

class SiteRootTest < ActionDispatch::IntegrationTest
  test 'index page has the following functioning links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_user_registration_path
    assert_select 'a[href=?]', new_user_session_path
  end
end
