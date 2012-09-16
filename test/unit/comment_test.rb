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
    @comment = Comment.new(:owner_id => 1, :post_id => 1)
    assert_equal @comment.valid?, false

    # Valid comment
    @comment = Comment.new(:text => 'New comment text', :owner_id => 1, :post_id => 1)
    assert_equal @comment.valid?, true
  end
end
