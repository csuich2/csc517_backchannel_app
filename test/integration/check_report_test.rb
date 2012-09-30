require 'test_helper'

class CheckReportTest < ActionDispatch::IntegrationTest
  # To change this template use File | Settings | File Templates.

  test 'check report' do
    login('test', 'testing')

    get_via_redirect '/users'
    assert_equal '/users', path

    get_via_redirect '/users/votes/2'
    assert_equal '/users/votes/2', path

    post_via_redirect '/users/votes/2'
    assert_response :success
    assert_equal '/users/votes/2', path

    assert_select "title", {:count => 1}, "Count is not 2"
    assert_select "h1", {:text => "User's votes"}
    assert_select "h2", {:text => "User's posts"}
    assert_select "table" do
      assert_select "tr" do
        assert_select "th", {:text => "Post title"}
        assert_select "th", {:text => "# of votes"}
      end
    end

    assert_select "table" do
      assert_select "tr" do
        assert_select "th", {:text => "Comment text"}
        assert_select "th", {:text => "# of votes"}
      end
    end

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