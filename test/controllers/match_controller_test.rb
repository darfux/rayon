require 'test_helper'

class MatchControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get match" do
    get :match
    assert_response :success
  end

end
