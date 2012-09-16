require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @categories = categories(:category1, :category2, :category3)
  end

  def teardown
    @categories = nil
  end

  test "validity" do
    # Missing name
    @category = Category.new()
    assert_equal @category.valid?, false

    # Name too name
    @category = Category.new(:name => 'a')
    assert_equal @category.valid?, false

    # Name too name
    @category = Category.new(:name => 'abcde12345abcde12345abcde')
    assert_equal @category.valid?, false

    # Valid category
    @category = Category.new(:name => 'New category')
    assert_equal @category.valid?, true
  end
end
