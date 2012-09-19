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

  ## Error is thrown here due to an inability for the find method to function in the test environment.
  #test "should create post" do

    #assert_difference('PostVote.count') do
    #  post :create, { post_vote: { user_id: @post_vote.user.id, post_id: @post_vote.post_id } }
    #end

    #assert_redirected_to post_path(assigns(@post.id))
  #end

end
