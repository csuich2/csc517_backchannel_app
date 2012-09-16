require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @posts = posts(:post1)
    @categories = categories(:category1, :category2, :category3)
  end

  def teardown
    @posts = nil
    @categories = nil
  end

  test "validity" do
    # Missing title
    @post = Post.new(:text => 'Test post', :category_id => 1)
    assert_equal @post.valid?, false

    # Title too short
    @post = Post.new(:title => 'a', :text => 'Test post', :category_id => 1)
    assert_equal @post.valid?, false

    # Title too long
    @post = Post.new(:title => 'abcde12345abcde12345abcde' , :text => 'Test post', :category_id => 1)
    assert_equal @post.valid?, false

    # Missing text
    @post = Post.new(:title => 'New post title', :category_id => 1)
    assert_equal @post.valid?, false

    # Missing category_id
    @post = Post.new(:title => 'New post title', :text => 'Test post')
    assert_equal @post.valid?, false

    # Invalid category_id
    @post = Post.new(:title => 'New post title', :text => 'Test post', :category_id => 100)
    assert_equal @post.valid?, false

    # Valid post
    @post = Post.new(:title => 'New post title', :text => 'Test post', :category_id => 1)
    assert_equal @post.valid?, true
  end
end
