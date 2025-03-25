require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "the root path" do
    get root_url
    assert_response :success
  end

  test "the about path" do
    get about_url
    assert_response :success
  end
end
