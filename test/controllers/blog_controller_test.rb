require 'test_helper'

class BlogControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
    assert_select "tbody tr", assigns(:articles).size
  end

end
