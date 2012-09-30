require 'test_helper'

class DeleteUserTest < ActionDispatch::IntegrationTest
  # check for admin
  test 'delete user' do
    get '/logout'
    get '/login'
    login('test', 'testing')

    # Saving the count of total number of users before deletion
    user_count_before_delete = User.all.size

    get_via_redirect '/users'
    assert_equal '/users', path
    assert_select "h1", {:count => 2}

    # Checking the table display before deleting the user
    table_display(user_count_before_delete)

    # Deleting user with id 3
    post '/users/destroy/3'
    assert_response :redirect
    follow_redirect!
    assert_equal '/users', path

    # Saving the count of total number of users after deletion
    user_count_after_delete = User.all.size

    # Comparison of total number of users, before and after the deletion. Users after deletion should be one less than before deletion
    assert_equal user_count_before_delete, user_count_after_delete + 1

    # Checking the table display after deleting the user
    table_display(user_count_after_delete)

    get '/logout'
  end

  # check for non-admin
  test 'non-admin unable to delete user' do
    get '/logout'
    get '/login'
    login('test2', 'testing')

    count_before_delete_attempt = User.all.size

    get_via_redirect '/users'
    assert_not_equal '/users', path
    assert_equal '/home', path
    assert_equal 'You are not authorized to view that page.', flash[:notice]

    post_via_redirect '/users/destroy/3'
    assert_equal '/home', path
    assert_equal 'You are not authorized to view that page.', flash[:notice]

    count_after_delete_attempt = User.all.size

    # Checking whether the count before delete attempt and after delete attempt is same or not
    assert_equal count_before_delete_attempt, count_after_delete_attempt
    get '/logout'
  end

  def login(username, password)
    get '/logout'
    get '/login'
    assert_response :success

    post_via_redirect '/sessions/login_attempt', :username => username, :login_password => password
    assert_equal '/home', path
    assert_equal "Welcome, #{username}!", flash[:notice]
  end

  def logout
    get_via_redirect '/logout'
    assert_equal '/', path
  end

  def table_display(count)

    assert_select "table" do
      assert_select "tr", {:count => count + 1} do # +1 to add the Row headers in the count as well
        assert_select "th", {:text => 'Username'}
        assert_select "th", {:text => 'Is admin?'}
        assert_select "th", {:text => ''}
      end

    end

  end

end