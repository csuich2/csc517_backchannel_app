require 'test_helper'
require_relative 'testing_mixin'

class VotingTest < ActionDispatch::IntegrationTest
  include TestingMixin
  test 'create comment vote' do
    login('test', 'testing')

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    post_via_redirect '/comments/1/comment_votes'
    assert_equal '/posts/1', path
    assert_equal 'Comment vote was successfully created.', flash[:notice]

    logout
  end

  test 'create post vote' do
    login('test', 'testing')

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    post_via_redirect '/posts/1/post_votes'
    assert_equal '/posts/1', path
    assert_equal 'Post vote was successfully created.', flash[:notice]

    logout
  end
end
