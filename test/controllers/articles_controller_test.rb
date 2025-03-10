require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user_article = articles(:first_article)
    @default_user_article = articles(:second_article)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new when logged in" do
    sign_in_as(users(:default_user))
    get new_article_url
    assert_response :success
  end

  test "should not get new when not logged in" do
    get new_article_url
    assert_redirected_to login_url
  end

  test "should create article" do
    sign_in_as(users(:default_user))
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: "new article title", description: "new article description" } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@default_user_article)
    assert_response :success
  end

  test "should edit for own article" do
    sign_in_as(users(:default_user))
    get edit_article_url(@default_user_article)
    assert_response :success
  end

  test "should not edit other user's article" do
    sign_in_as(users(:default_user))
    get edit_article_url(@admin_user_article)
    assert_redirected_to article_url(@admin_user_article)
  end

  test "should update own article" do
    sign_in_as(users(:default_user))
    patch article_url(@default_user_article), params: { article: { title: "updated title", description: "updated description" } }
    assert_redirected_to article_url(@default_user_article)
  end

  test "should not update other user's article" do
    sign_in_as(users(:default_user))
    patch article_url(@default_user_article), params: { article: { title: "updated title", description: "updated description" } }
    assert_redirected_to article_url(@default_user_article)
  end

  test "should destroy own article" do
    sign_in_as(users(:default_user))
    assert_difference("Article.count", -1) do
      delete article_url(@default_user_article)
    end

    assert_redirected_to articles_url
  end

  test "should not destroy other user's article" do
    sign_in_as(users(:default_user))
    assert_no_difference("Article.count") do
      delete article_url(@admin_user_article)
    end

    assert_redirected_to @admin_user_article
  end

  test "admin should destroy other user's article" do
    sign_in_as(users(:admin_user))
    assert_difference("Article.count", -1) do
      delete article_url(@default_user_article)
    end

    assert_redirected_to articles_url
  end
end
