require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:cat_sports)
    @default_user = users(:default_user)
    @admin_user = users(:admin_user)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new as admin" do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "should not get new as non admin" do
    sign_in_as(@default_user)
    get new_category_url
    assert_redirected_to categories_url
  end

  test "should create category" do
    sign_in_as(@admin_user)
    assert_not_nil(session[:user_id])
    assert_difference("Category.count", 1) do
      post categories_url, params: { category: { name: "Finance" } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not logged in" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Finance" } }
    end

    assert_redirected_to categories_url
  end

  test "should not create category if not admin" do
    sign_in_as(@default_user)
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Finance" } }
    end

    assert_redirected_to categories_url
  end

  test "should not create duplicate category" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Sports" } }
    end

    assert_redirected_to categories_url
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit as admin" do
    sign_in_as(@admin_user)
    get edit_category_url(@category)
    assert_response :success
  end


  test "should not get edit as non admin" do
    sign_in_as(@default_user)
    get edit_category_url(@category)
    assert_redirected_to categories_url
  end


  test "should update category as admin" do
    sign_in_as(@admin_user)
    patch category_url(@category), params: { category: { name: "Leisure" } }
    assert_redirected_to category_url(@category)
  end

  test "should not update category as non admin" do
    sign_in_as(@default_user)
    patch category_url(@category), params: { category: { name: "Leisure" } }
    assert_redirected_to categories_url
  end

  # TODO add destroy action to CategoriesCOntroller
  # test "should destroy category as admin" do
  #   sign_in_as(@admin_user)
  #   assert_difference("Category.count", -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
  # test "should not destroy category as non admin" do
  #   sign_in_as(@default_user)
  #   assert_difference("Category.count", -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
