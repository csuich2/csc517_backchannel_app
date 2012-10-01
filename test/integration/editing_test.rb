require 'test_helper'
require_relative 'testing_mixin'

class EditingTest < ActionDispatch::IntegrationTest
  include TestingMixin
  test 'admin edit post' do
    login('test', 'testing')

    get_via_redirect '/posts'
    assert_equal '/posts', path

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    get_via_redirect '/posts/1/edit'
    assert_equal '/posts/1/edit', path

    put_via_redirect '/posts/1', :post => { :title => 'Edit Title', :category_id => 1, :text => 'Edit Post Text' }
    assert_equal '/posts/1', path
    assert_equal 'Post was successfully updated.', flash[:notice]

    logout
  end

  test 'user edit post' do
    login('test2', 'testing')

    get_via_redirect '/posts'
    assert_equal '/posts', path

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    get_via_redirect '/posts/1/edit'
    assert_equal '/posts/1/edit', path

    put_via_redirect '/posts/1', :post => { :title => 'Edit Title', :category_id => 1, :text => 'Edit Post Text' }
    assert_equal '/posts/1', path
    assert_equal 'Post was successfully updated.', flash[:notice]

    logout
  end

  test 'admin edit comment' do
    login('test', 'testing')

    get_via_redirect '/posts'
    assert_equal '/posts', path

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    put_via_redirect '/posts/1/comments/1', :comment => { :text => 'Edited Text' }
    assert_equal '/posts/1', path
    assert_equal 'Comment was successfully updated.', flash[:notice]

    logout
  end

  test 'user edit comment' do
    login('test2', 'testing')

    get_via_redirect '/posts'
    assert_equal '/posts', path

    get_via_redirect '/posts/1'
    assert_equal '/posts/1', path

    put_via_redirect '/posts/1/comments/1', :comment => { :text => 'Edited Text' }
    assert_equal '/posts/1', path
    assert_equal 'Comment was successfully updated.', flash[:notice]

    logout
  end
end
