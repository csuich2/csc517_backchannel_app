require 'test_helper'

class DeleteUserTest < ActionDispatch::IntegrationTest
  test 'delete user' do
    get '/logout'
    get '/login'
    login('test', 'testing')
    get_via_redirect '/users'
    assert_equal '/users', path
    post_via_redirect '/users/destroy/3'
    assert_response :success
    assert_equal '/users', path
    get '/logout'
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