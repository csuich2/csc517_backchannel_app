require 'test_helper'

class CommentVoteTest < ActiveSupport::TestCase
  def setup
    @comments = comments(:comment1)
    @posts = posts(:post1)
    @categories = categories(:category1, :category2, :category3)
    @users = users(:user1, :user2, :user3)
  end

  def teardown
    @comments = nil
    @posts = nil
    @categories = nil
    @users = nil
  end

  test "validity" do
    #Test missing a user
    @comment_vote = CommentVote.new(:comment_id => 1)
    assert_equal false, @comment_vote.valid?

    #Test missing a post
    @comment_vote = CommentVote.new(:user_id => 1)
    assert_equal false, @comment_vote.valid?

    #Test user owns comment - Not a path accessible through the UI
    #@comment_vote = CommentVote.new(:user_id => 2, :comment_id => 1)
    #assert_equal false, @comment_vote.valid?

    #Test creating a valid post_vote
    @comment_vote = CommentVote.new(:user_id => 1, :comment_id => 1)
    assert_equal true, @comment_vote.valid?
  end
end
