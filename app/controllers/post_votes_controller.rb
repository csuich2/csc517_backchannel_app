class PostVotesController < ApplicationController
  before_filter :authenticate_user

  # POST /post_votes
  # POST /post_votes.json
  def create
    @post_vote = PostVote.new(params[:post_vote])
    put @post_vote
    @post_vote.owner_id = @current_user.id
    @post_vote.post_id = 1
    @post = Post.find(1)

    respond_to do |format|
      if @post_vote.save
        format.html { redirect_to post_path(@post), notice: 'Post vote was successfully created.' }
      else
        format.html { redirect_to post_path(@post), notice: 'Post vote was successfully created.' }
      end
    end
  end

  # DELETE /post_votes/1
  # DELETE /post_votes/1.json
  def destroy
    @post_vote = PostVote.find(params[:id])

    assert_is_owner_or_admin(@post_vote.owner_id)

    @post_vote.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: 'Vote was successfully deleted.' }
    end
  end

  def getVoteCount
    @post = Post.find(params[:id])

  end

  def hasVoted
  end
end
