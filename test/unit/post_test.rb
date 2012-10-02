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
    @post = Post.new(:text => 'Test post', :category_id => 1, :user_id => 1)
    assert_equal false, @post.valid?

    # Title too short
    @post = Post.new(:title => 'a', :text => 'Test post', :category_id => 1, :user_id => 1)
    assert_equal false, @post.valid?

    # Title too long
    @post = Post.new(:title => 'abcde12345abcde12345abcde' , :text => 'Test post', :category_id => 1, :user_id => 1)
    assert_equal false, @post.valid?

    # Missing text
    @post = Post.new(:title => 'New post title', :category_id => 1, :user_id => 1)
    assert_equal false, @post.valid?

    # Missing category_id
    @post = Post.new(:title => 'New post title', :text => 'Test post', :user_id => 1)
    assert_equal false, @post.valid?

    # Missing user_id
    @post = Post.new(:title => 'New post title', :text => 'Test post', :category_id => 1)
    assert_equal false, @post.valid?

    # Valid post
    @post = Post.new(:title => 'New post title', :text => 'Test post', :category_id => 1, :user_id => 1)
    assert_equal true, @post.valid?
  end

  test 'post search' do
    @results = Post.search('Test post 1')
    assert_equal 1, @results.size

    @results = Post.search('Test post')
    assert_equal 2, @results.size

    @results = Post.search('Test comment from owner')
    assert_equal 1, @results.size
  end
end
