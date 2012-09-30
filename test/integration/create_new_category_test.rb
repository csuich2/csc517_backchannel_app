require 'test_helper'

class CreateNewCategoryTest < ActionDispatch::IntegrationTest
  # To change this template use File | Settings | File Templates.

  test 'create new category' do
    login('test', 'testing')

    get_via_redirect '/categories'
    assert_equal '/categories', path

    get_via_redirect '/categories/new'
    assert_equal '/categories/new', path

    post_via_redirect '/categories/create', :category => {:name => 'Test Category'}
    assert_response :success
    assert_equal '/categories', path
    assert_equal 'Category was successfully created.', flash[:notice]

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