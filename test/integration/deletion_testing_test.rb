require 'test_helper'
require_relative 'testing_mixin'

class DeletionTestingTest < ActionDispatch::IntegrationTest
  include TestingMixin

  test 'delete comment' do
    login('test3', 'testing')

    get_via_redirect 'posts/1'
    assert_equal '/posts/1', path

    #Try to delete someone else's comment
    #delete_via_redirect '/posts/1/comments/1'
    #assert_equal '/home', path

    #Try to delete your comment
    delete_via_redirect '/posts/1/comments/4'
    assert_equal '/posts/1', path
    assert_equal 'Comment was successfully deleted.', flash[:notice]

  end

  test 'delete post' do
    login('test3', 'testing')

    get_via_redirect 'posts'
    assert_equal '/posts', path

    #Try to delete someone else's post
    delete_via_redirect '/posts/1'
    assert_equal '/home', path

    login('test3', 'testing')


    #Try to delete your post
    delete_via_redirect '/posts/2'
    assert_equal '/posts', path
    assert_equal 'Post was successfully deleted.', flash[:notice]

  end

end
