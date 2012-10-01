require 'test_helper'
require_relative 'testing_mixin'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include TestingMixin

  test 'log in' do
    login('test', 'testing')
  end

  test 'create category' do
    login('test', 'testing')

    get_via_redirect '/categories'
    assert_equal '/categories', path

    get_via_redirect '/categories/new'
    assert_equal '/categories/new', path

    post_via_redirect '/categories', :category => {:name => 'Test Category'}
    assert_equal '/categories', path
    assert_equal 'Category was successfully created.', flash[:notice]

    logout
  end

  test 'create post' do
    login('test', 'testing')

    get_via_redirect '/posts'
    assert_equal '/posts', path

    get_via_redirect '/posts/new'
    assert_equal '/posts/new', path

    post_via_redirect '/posts', :post => { :title => 'Test Title', :category_id => 1, :text => 'Integration Post Text' }
    assert_equal '/posts/3', path
    assert_equal 'Post was successfully created.', flash[:notice]

    logout
  end

  test 'create comment' do
    login('test', 'testing')

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    post_via_redirect '/posts/1/comments', :comment => { :text => 'Integration Comment Text' }
    assert_equal '/posts/1', path
    assert_equal 'Comment was successfully created.', flash[:notice]

    logout
  end

  test 'create user' do
    get '/signup'
    post_via_redirect '/users', :user => {:username => 'Int Test', :password => 'testing', :password_confirmation => 'testing'}
    assert_equal '/home', path
  end
end
