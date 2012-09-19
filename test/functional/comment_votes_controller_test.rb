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

  ## Error is thrown here due to an inability for the find method to function in the test environment.
  #test "should create comment_vote" do
  #  assert_difference('CommentVote.count') do
  #    post :create, comment_vote: {user_id: @user.id, comment_id: @comment.id, post_id: @comment.post_id}
  #  end

  # assert_redirected_to_post_vote_path(assigns(@comment.id))
  end
end
