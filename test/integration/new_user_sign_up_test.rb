require "test_helper"

class NewUserSignUpTest < ActionDispatch::IntegrationTest
  test "sign up new user" do
    get "/signup"
    assert_response :success
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "Bob", email: "bob@example.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Bob", response.body
  end
end
