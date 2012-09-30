require 'test_helper'

class VotingTest < ActionDispatch::IntegrationTest
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

  def login(username, password)
    get '/logout'
    get '/login'
    assert_response :success

    post_via_redirect '/sessions/login_attempt', :username => username, :login_password => password
    assert_equal '/home', path
    assert_equal 'Welcome, ' + username + '!', flash[:notice]
  end

  def logout
    get_via_redirect '/logout'
    assert_equal '/', path
  end
end
