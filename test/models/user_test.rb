require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create user when users are empty" do
    User.delete_all
    assert_difference('User.count') do
      user = User.create_if_empty('hank', 'secret')
      assert_equal 'hank', user.name
      assert user.authenticate('secret')
    end
  end

  test "should return correct user by name when users is not empty" do
    hank = users(:two)
    user = User.create_if_empty(hank.name, 'secret')
    assert_equal hank.id, user.id
  end
end
