require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:cat_sports)
  end


  test "category should be valid" do
    assert @category.valid?
  end

  test "category name is required" do
    @category.name = " "
    assert_not @category.valid?
  end
  test "category name should be unique" do
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?
  end

  test "category name length should be 25 character maximum" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "category name length should be 3 characters minimum" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end
