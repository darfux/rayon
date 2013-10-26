require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get project" do
    get :project
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get achievement" do
    get :achievement
    assert_response :success
  end

  test "should get paper" do
    get :paper
    assert_response :success
  end

  test "should get expert" do
    get :expert
    assert_response :success
  end

end
