require 'test_helper'

class CommentVotesControllerTest < ActionController::TestCase
  setup do
    @post = posts(:post1)
    @user = users(:user1)
    @category = categories(:category1)
    @comment = comments(:comment1)
    @comment_vote = comment_votes(:commentvote1)

    @current_user = @user
    session[:user_id] = @current_user.id
  end

  test "should create comment_vote" do
    assert_difference('CommentVote.count') do
      post :create, comment_id: @comment.id
    end

    assert assigns(:comment_vote)
    assert_redirected_to post_path(@comment.post.id)
  end
end
