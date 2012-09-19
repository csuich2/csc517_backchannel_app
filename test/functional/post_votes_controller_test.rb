require 'test_helper'

class PostVotesControllerTest < ActionController::TestCase
  setup do
    @post = posts(:post1)
    @user = users(:user1)
    @category = categories(:category1)
    @post_vote = post_votes(:postvote1)

    @current_user = @user
    session[:user_id] = @current_user.id
  end


  test "should create post" do

    assert_difference('PostVote.count') do
      post :create, post_id: @post.id
    end

    assert assigns(:post_vote)
    assert_redirected_to post_path(@post.id)
  end

end
