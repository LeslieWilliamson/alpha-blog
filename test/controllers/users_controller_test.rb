require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:admin_user)
    @user = users(:default_user)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count", 1) do
      post users_url, params: { user: { username: "test", email: "test@example.com", password: "test" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    sign_in_as(@user)
    patch user_url(@user), params: { user: { username: "David", email: "david@example.com", password: "password" } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    sign_in_as(@admin_user)

    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should destroy user (self)" do
    sign_in_as(@admin_user)

    assert_difference("User.count", -1) do
      delete user_url(@admin_user)
    end

    assert_redirected_to signup_url
  end
end
