require 'test_helper'
require_relative 'testing_mixin'

class CheckReportTest < ActionDispatch::IntegrationTest
  include TestingMixin

  # check for Admin
  test 'check report' do
    login('test', 'testing')

    get_via_redirect '/users'
    assert_equal '/users', path
    # Retrieve the report for User with id 2
    get_via_redirect '/users/votes/2'
    assert_equal '/users/votes/2', path
    assert_response :success

    # Verifying the HTML elements
    assert_select "title", {:count => 1}, "Title Count is 1."
    assert_select "h1", {:count => 1, :text => "User's votes"}, "H1 header Count is 1."
    assert_select "h2", {:count => 1, :text => "User's posts"}, "H2 header Count is 1."

    # Verifying the User's posts table elements
    assert_select "table" do
      assert_select "tr" do
        assert_select "th", {:text => "Post title"}
        assert_select "th", {:text => "# of votes"}
      end
    end

    # Verifying the User's comments table elements
    assert_select "table" do
      assert_select "tr" do
        assert_select "th", {:text => "Comment text"}
        assert_select "th", {:text => "# of votes"}
      end
    end

    logout
  end


    #check for non-admin
  test 'non-admin not able to check report' do
    login('test2', 'testing')

    get_via_redirect '/users'
    assert_not_equal '/users', path
    assert_equal '/home', path
    assert_equal 'You are not authorized to view that page.', flash[:notice]

    get_via_redirect '/users/votes/3'
    assert_not_equal '/users/votes/3', path
    assert_equal '/home', path
    assert_equal 'You are not authorized to view that page.', flash[:notice]

  end

end
