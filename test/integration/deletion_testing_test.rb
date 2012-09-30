require 'test_helper'

class DeletionTestingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end


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
