class CommentVotesController < ApplicationController
  before_filter :authenticate_user
  # GET /comment_votes
  # GET /comment_votes.json
  def index
    @comment_votes = CommentVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comment_votes }
    end
  end

  # GET /comment_votes/1
  # GET /comment_votes/1.json
  def show
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/new
  # GET /comment_votes/new.json
  def new
    @comment_vote = CommentVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/1/edit
  def edit
    @comment_vote = CommentVote.find(params[:id])
  end

  # POST /comment_votes
  # POST /comment_votes.json
  def create
    @comment_vote = CommentVote.new(params[:comment_vote])
    @comment_vote.user = @current_user
    @comment_vote.comment = Comment.find(params[:comment_id])

    respond_to do |format|
      if @comment_vote.save
        format.html { redirect_to post_path(Post.find(@comment_vote.post_id)), :notice => 'Comment vote was successfully created.' }
      else
        format.html { redirect_to post_path(@comment_vote.post_id), :notice => 'Comment vote was not created.' }
      end
    end
  end

  # PUT /comment_votes/1
  # PUT /comment_votes/1.json
  def update
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      if @comment_vote.update_attributes(params[:comment_vote])
        format.html { redirect_to @comment_vote, notice: 'Comment vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_votes/1
  # DELETE /comment_votes/1.json
  def destroy
    @comment_vote = CommentVote.find(params[:id])
    @comment_vote.destroy

    respond_to do |format|
      format.html { redirect_to comment_votes_url }
      format.json { head :no_content }
    end
  end
end
