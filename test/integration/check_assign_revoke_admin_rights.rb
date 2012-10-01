require 'test_helper'
require_relative 'testing_mixin'

class CheckAssignRevokeAdminRights < ActionDispatch::IntegrationTest
  include TestingMixin
  test 'admin assigns admin rights' do
    get '/logout'
    get '/login'
    login('test', 'testing')

    get_via_redirect '/users'
    # Check whether the row displays that the user does not have admin privileges before being assigned admin privileges
    assert_select "tr" do
      assert_select "td", {:text => 'test2'}
      assert_select "td", {:text => 'false'}
      assert_select "td" do
        assert_select "a", {:text => "Make admin"}
        assert_select "a", {:text => "Delete"}
        assert_select "a", {:text => "Vote report"}
      end
    end

    post_via_redirect '/users/make_admin/2'
    assert_equal '/users', path
    # Check Flash message
    assert_equal 'test2 has been granted admin rights', flash[:notice]

    # Check whether the row is updated or not for the user who has been given admin access
    assert_select "tr" do
      assert_select "td", {:text => 'test2'}
      assert_select "td", {:text => 'true'}
      assert_select "td" do
        assert_select "a", {:text => "Revoke admin"}
        assert_select "a", {:text => "Delete"}
        assert_select "a", {:text => "Vote report"}
      end
    end
  end


  test 'admin revokes admin rights' do
    get '/logout'
    get '/login'
    login('test', 'testing')

    get_via_redirect '/users'
    # Check whether the row displays that the user has admin privileges before revoking admin privileges
    assert_select "tr" do
      assert_select "td", {:text => 'test2'}
      assert_select "td", {:text => 'true'}
      assert_select "td" do
        assert_select "a", {:text => "Revoke admin"}
        assert_select "a", {:text => "Delete"}
        assert_select "a", {:text => "Vote report"}
      end
    end

    post_via_redirect '/users/revoke_admin/2'
    assert_equal '/users', path
    # Check Flash message
    assert_equal "test2's admin rights have been revoked.", flash[:notice]

    # Check whether the row is updated for the user whose admin rights have been revoked
    assert_select "tr" do
      assert_select "td", {:text => 'test2'}
      assert_select "td", {:text => 'false'}
      assert_select "td" do
        assert_select "a", {:text => "Make admin"}
        assert_select "a", {:text => "Delete"}
        assert_select "a", {:text => "Vote report"}
      end
    end
  end

  test 'admin tries to revokes its own admin rights' do
    get '/logout'
    get '/login'
    login('test', 'testing')

    get_via_redirect '/users'

    # Check whether for admin who is logged in, the option of making/revoking admin is not presented
    assert_select "tr" do
      assert_select "td", {:text => 'test'}
      assert_select "td", {:text => 'true'}
      assert_select "td" do
        assert_select "a", {:text => "Make admin"}
        assert_select "a", {:text => "Vote report"}
      end
    end
  end

end