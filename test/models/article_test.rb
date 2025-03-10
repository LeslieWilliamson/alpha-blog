require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = articles(:third_article)
  end
  test "Article is valid" do
    assert @article.valid?
  end

  test "Article title is required" do
    @article.title = nil
    assert_not @article.valid?
    assert_not_nil @article.errors[:title]
  end

  test "Article description is required" do
    @article.description = nil
    assert_not @article.valid?
    assert_not_nil @article.errors[:description]
  end

  test "Article author is required" do
    @article.user_id = nil
    assert_not @article.valid?
    assert_not_nil @article.errors[:users]
  end

  test "Article existing author is required" do
    @article.user_id = -1
    assert_not @article.valid?
    assert_not_nil @article.errors[:users]
  end

  test "Article title is minimum 6 characters" do
    @article.title = "t" * 5
    assert_not @article.valid?
    assert_not_nil @article.errors[:title]
  end

  test "Article title is maximum 100 characters" do
    @article.title = "t" * 101
    assert_not @article.valid?
    assert_not_nil @article.errors[:title]
  end
  test "Article description is minimum 10 characters" do
    @article.description = "d" * 9
    assert_not @article.valid?
    assert_not_nil @article.errors[:description]
  end

  test "Article description is maximum 300 characters" do
    @article.description = "d" * 301
    assert_not @article.valid?
    assert_not_nil @article.errors[:description]
  end
end
