require "test_helper"

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "Jacob Two Two", email: "jacob22@hoodedfang.com", password: "password")
  end
  test "create a new article" do
    sign_in_as @user
    get "/articles/new"
    assert_response :success

    assert_difference "Article.count", 1 do
     post articles_path, params: { article: { title: "test title", description: "test decription", category_ids: [] } }
     assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match Article.last.title, response.body
    assert_match Article.last.description, response.body
  end
end
