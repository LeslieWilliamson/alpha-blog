require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "Article is valid" do
    user = User.create(username: "Leslie", email: "leslie@example.com", password: "password")
    assert user.valid?

    article = Article.new(title: "Some title", description: "Some article description")
    article.user_id = user.id
    assert article.valid?
  end

  test "Article title is required" do
    article = Article.new(title: "", description: "Some article description")
    assert_not article.valid?
    assert_not_nil article.errors[:title]
  end

  test "Article description is required" do
    article = Article.new(title: "Some title", description: "")
    assert_not article.valid?
    assert_not_nil article.errors[:description]
  end

  test "Article author is required" do
    article = Article.new(title: "Some title", description: "Some article description")
    assert_not article.valid?
    assert_not_nil article.errors[:users]
  end
end
