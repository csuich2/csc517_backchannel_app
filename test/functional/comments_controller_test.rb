require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user1)
    @comment = comments(:comment1)

    @current_user = @user
    session[:user_id] = @current_user.id
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, { comment: { user_id: @comment.user.id, text: @comment.text }, post_id: @comment.post.id }
    end

    assert assigns :comment
    assert_redirected_to post_path(@comment.post)
  end

  test "should update comment" do
    put :update, id: @comment, comment: { user_id: @comment.user.id, post_id: @comment.post.id,  text: @comment.text }
    assert assigns(:comment)
    assert_redirected_to post_path(@comment.post)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to post_path(@comment.post)
  end
end
