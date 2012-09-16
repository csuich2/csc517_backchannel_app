require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @users = users(:user1, :user2, :user3)
  end

  def teardown
    @users = nil
  end

  test "is admin" do
    assert_equal @users[0].is_admin, true
    assert_equal @users[1].is_admin, false
    assert_equal @users[2].is_admin, false
  end

  test "match password" do
    assert_equal @users[0].match_password('testing'), true
  end

  test "encrypt password" do
    assert_equal @users[0].match_password('changed password'), false
    @users[0].password = 'changed password'
    @users[0].encrypt_password
    assert_equal @users[0].match_password('changed password'), true
  end

  test "clear password" do
    @users[0].password = 'new password'
    @users[0].clear_password
    assert_equal @users[0].password, nil
  end

  test "validity" do
    # Missing username
    @user = User.new(:password => 'testing', :password_confirmation => 'testing')
    assert_equal @user.valid?, false

    # Missing password
    @user = User.new(:username => 'a', :password_confirmation => 'testing')
    assert_equal @user.valid?, false

    # Missing password confirmation
    @user = User.new(:username => 'a', :password => 'testing')
    assert_equal @user.valid?, false

    # Username too short
    @user = User.new(:username => 'a', :password => 'testing', :password_confirmation => 'testing')
    assert_equal @user.valid?, false

    # Username already exists
    @user = User.new(:username => 'test', :password => 'testing', :password_confirmation => 'testing')
    assert_equal @user.valid?, false

    # Username too long
    @user = User.new(:username => 'abcde12345abcde12345abcde12345abcde', :password => 'testing', :password_confirmation => 'testing')
    assert_equal @user.valid?, false

    # Passwords do not match
    @user = User.new(:username => 'user', :password => 'testing', :password_confirmation => 'testing2')
    assert_equal @user.valid?, false

    # Password too short
    @user = User.new(:username => 'user', :password => 'test', :password_confirmation => 'test')
    assert_equal @user.valid?, false

    # Password too long
    @user = User.new(:username => 'user2', :password => 'abcde12345abcde12345abcde12345abcde', :password_confirmation => 'abcde12345abcde12345abcde12345abcde')
    assert_equal @user.valid?, false

    # Valid
    @user = User.new(:username => 'new_user', :password => 'testing', :password_confirmation => 'testing')
    assert_equal @user.valid?, true
  end
end
