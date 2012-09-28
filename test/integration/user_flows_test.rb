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

    post_via_redirect '/categories', :category_name => 'Integration Test Category'
    assert_equal '/categories', path
    assert_equal 'Category was successfully created.', flash[:notice]
  end

  def login(username, password)
    get '/logout'
    get '/login'
    assert_response :success

    post_via_redirect '/sessions/login_attempt', :username => username, :login_password => password
    assert_equal '/home', path
    assert_equal 'Welcome, test!', flash[:notice]
  end
end
