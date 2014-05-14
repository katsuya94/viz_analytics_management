require 'test_helper'

class MetricsControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get details" do
    get :details
    assert_response :success
  end

end
