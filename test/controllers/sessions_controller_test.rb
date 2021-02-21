require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login successfully by correct name and password" do
    user = users(:one)
    post :create, name: user.name, password: 'secret'
    assert_redirected_to articles_url
    assert_equal user.id, session[:user_id]
  end

  test "should login failed by incorrect name or password" do
    user = users(:one)
    post :create, name: user.name, password: 'Invalid Password'
    assert_redirected_to login_path
    assert_equal 'Invalid username/password combination!', flash[:notice]
  end

  test "should create user when users is empty" do
    logout
    User.delete_all
    assert_difference('User.count') do
      post :create, name: 'cloneable', password: 'secret'
    end
    assert_redirected_to articles_url
    assert_not_nil session[:user_id]

    user = User.find(session[:user_id])
    assert_equal 'cloneable', user.name
    assert user.authenticate('secret')
  end

  test "should get destroy" do
    delete :destroy
    assert_redirected_to blog_url
    assert_nil session[:user_id]
  end

end
