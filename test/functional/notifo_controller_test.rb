require 'test_helper'

class NotifoControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

end
