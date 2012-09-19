require 'test_helper'

class PostVoteTest < ActiveSupport::TestCase

  def setup
    @posts = posts(:post1)
    @users = users(:user1, :user2, :user3)
  end

  def teardown
    @posts = nil
    @users = nil
  end

  test "validity" do
    #Test missing a user
    @post_vote = PostVote.new(:post_id => 1)
    assert_equal false, @post_vote.valid?

    #Test missing a post
    @post_vote = PostVote.new(:user_id => 1)
    assert_equal false, @post_vote.valid?

    #Test user owns post - Not a path accessible through the UI
    #@post_vote = PostVote.new(:user_id => 2, :post_id => 1)
    #assert_equal false, @post_vote.valid?

    #Test creating a valid post_vote
    @post_vote = PostVote.new(:user_id => 1, :post_id => 1)
    assert_equal true, @post_vote.valid?
  end
end
