require 'test_helper'
require_relative 'testing_mixin'

class CreateNewCategoryTest < ActionDispatch::IntegrationTest
  include TestingMixin

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


end