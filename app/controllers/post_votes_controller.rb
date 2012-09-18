class PostVotesController < ApplicationController
  before_filter :authenticate_user

  # POST /post_votes
  def create
    @post_vote = PostVote.new(params[:post_vote])
    @post_vote.user = @current_user
    @post_vote.post = Post.find(params[:post_id])

    respond_to do |format|
      if @post_vote.save
        format.html { redirect_to post_path(@post_vote.post), :notice => 'Post vote was successfully created.' }
      else
        format.html { redirect_to post_path(@post_vote.post), :notice => 'Post vote was successfully created.' }
      end
    end
  end

end
