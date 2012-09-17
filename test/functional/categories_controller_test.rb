require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @user = users(:user1)
    @category = categories(:category1)

    @current_user = @user
    session[:user_id] = @current_user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, category: { name: @category.name + " new" }
    end

    assert assigns(:category)
    assert_redirected_to categories_path()
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categories_path
  end
end
