require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get isiton" do
    get :isiton
    assert_response :success
  end

  test "should get recommend" do
    get :recommend
    assert_response :success
  end

  test "should get randomMovie" do
    get :randomMovie
    assert_response :success
  end

end
