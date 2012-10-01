require 'test_helper'
require_relative 'testing_mixin'

class SearchTest < ActionDispatch::IntegrationTest
  include TestingMixin
  test 'search' do
    login('test', 'testing')

    get_via_redirect '/search'
    assert_equal '/search', path

    assert_select "h2", {:count => 3}
    assert_select "h2", {:text => 'Search by Category'}
    assert_select "h2", {:text => 'Search by User'}
    assert_select "h2", {:text => 'Search by Content'}

    # Search by Category
    get_via_redirect '/search_by_category?search[category_id]=1'
    assert_response :success

    assert_select "h1", {:count => 2}
    assert_select "table" do
      assert_select "tr" do
        assert_select "th", {:text => 'Title'}
        assert_select "th", {:text => 'Poster'}
        assert_select "th", {:text => ''}
      end
      assert_select "tr" do
        assert_select "td", {:text => 'Test post 1'}
        assert_select "td", {:text => 'test2'}
        assert_select "td" do
          assert_select "a", {:text => "Show"}
          assert_select "a", {:text => "Edit"}
          assert_select "a", {:text => "Destroy"}
        end
      end
      assert_select "tr" do
        assert_select "td", {:text => 'Test post 2'}
        assert_select "td", {:text => 'test3'}
        assert_select "td" do
          assert_select "a", {:text => "Show"}
          assert_select "a", {:text => "Edit"}
          assert_select "a", {:text => "Destroy"}
        end
      end
    end

    # Search by User
    get_via_redirect '/search_by_user?search[search]=test2'
    assert_response :success

    assert_select "h1", {:count => 2}
    assert_select "table" do
      assert_select "tr" do
        assert_select "th", {:text => 'Title'}
        assert_select "th", {:text => 'Poster'}
        assert_select "th", {:text => ''}
      end
      assert_select "tr" do
        assert_select "td", {:text => 'Test post 1'}
        assert_select "td", {:text => 'test2'}
        assert_select "td" do
          assert_select "a", {:text => "Show"}
          assert_select "a", {:text => "Edit"}
          assert_select "a", {:text => "Destroy"}
        end
      end
    end

    # Search by Content
    get_via_redirect '/search_by_content?search[search]=post+2'
    assert_response :success

    assert_select "h1", {:count => 2}
    assert_select "table" do
      assert_select "tr" do
        assert_select "th", {:text => 'Title'}
        assert_select "th", {:text => 'Poster'}
        assert_select "th", {:text => ''}
      end
      assert_select "tr" do
        assert_select "td", {:text => 'Test post 2'}
        assert_select "td", {:text => 'test3'}
        assert_select "td" do
          assert_select "a", {:text => "Show"}
          assert_select "a", {:text => "Edit"}
          assert_select "a", {:text => "Destroy"}
        end
      end
    end

  end

end