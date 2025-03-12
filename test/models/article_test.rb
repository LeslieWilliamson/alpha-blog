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

  test "Article valid author is required" do
    @article.user_id = -1
    assert_not @article.valid?
    assert_not_nil @article.errors[:users]
  end

  test "Article title minimum characters" do
    @article.title = "t" * 5
    assert_not @article.valid?
    assert_not_nil @article.errors[:title]
  end

  test "Article title maximum characters" do
    @article.title = "t" * 101
    assert_not @article.valid?
    assert_not_nil @article.errors[:title]
  end
  test "Article description minimum characters" do
    @article.description = "d" * 9
    assert_not @article.valid?
    assert_not_nil @article.errors[:description]
  end

  test "Article description maximum characters" do
    @article.description = "d" * 1001
    assert_not @article.valid?
    assert_not_nil @article.errors[:description]
  end
end
