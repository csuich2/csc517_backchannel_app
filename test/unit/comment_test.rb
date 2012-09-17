require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @users = users(:user1, :user2)
    @posts = posts(:post1)
    @categories = categories(:category1, :category2, :category3)
    @comments = comments(:comment1, :comment2)
  end

  def teardown
    @posts = nil
    @categories = nil
    @comments = nil
  end

  test "validity" do
    # Missing text
    @comment = Comment.new(:user_id => 1, :post_id => 1)
    assert_equal false, @comment.valid?

    # Missing user
    @comment = Comment.new(:text => 'Comment text', :post_id => 1)
    assert_equal false, @comment.valid?

    # Missing post
    @comment = Comment.new(:text => 'Comment text', :user_id => 1)
    assert_equal false, @comment.valid?

    # Valid comment
    @comment = Comment.new(:text => 'New comment text', :user_id => 1, :post_id => 1)
    assert_equal true, @comment.valid?
  end
end
