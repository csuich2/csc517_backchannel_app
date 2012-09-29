require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest

  test 'log in' do
    login('test', 'testing')
  end

  test 'create new category' do
    login('test', 'testing')

    get_via_redirect '/categories'
    assert_equal '/categories', path

    get_via_redirect '/categories/new'
    assert_equal '/categories/new', path

    post_via_redirect '/categories', :category => {:name => 'Integration Test Category'}
    assert_equal '/categories', path
    #assert_equal 'Category was successfully created.', flash[:notice]

    logout
  end

  test 'create new post' do
    login('test', 'testing')

    get_via_redirect '/posts'
    assert_equal '/posts', path

    get_via_redirect '/posts/new'
    assert_equal '/posts/new', path

    post_via_redirect '/posts', :post => { :title => 'Integration Test Title', :category_id => 1, :text => 'Integration Post Text' }
    assert_equal '/posts', path
    #assert_equal 'Post was successfully created.', flash[:notice]

    logout
  end

  test 'create new comment' do
    login('test', 'testing')

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    post_via_redirect '/posts/1/comments', :comment => { :text => 'Integration Comment Text' }
    assert_equal '/posts/1', path
    assert_equal 'Comment was successfully created.', flash[:notice]

    logout
  end

  def login(username, password)
    get '/logout'
    get '/login'
    assert_response :success

    post_via_redirect '/sessions/login_attempt', :username => username, :login_password => password
    assert_equal '/home', path
    assert_equal 'Welcome, test!', flash[:notice]
  end

  def logout
    get_via_redirect '/logout'
    assert_equal '/', path
  end
end
