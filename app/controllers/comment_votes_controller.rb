class CommentVotesController < ApplicationController
  before_filter :authenticate_user


  # POST /comment_votes
  def create
    @comment_vote = CommentVote.new(params[:comment_vote])
    @comment_vote.user = @current_user
    @comment_vote.comment = Comment.find(params[:comment_id])

    respond_to do |format|
      if @comment_vote.save
        format.html { redirect_to post_path(Post.find(@comment_vote.comment.post_id)), :notice => 'Comment vote was successfully created.' }
      else
        format.html { redirect_to post_path(Post.find(@comment_vote.comment.post_id)), :notice => 'Comment vote was not created.' }
      end
    end
  end


end
