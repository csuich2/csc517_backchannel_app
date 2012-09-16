class CommentsController < ApplicationController
  before_filter :authenticate_user

  # GET /comments/new
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  def create
    @comment = Comment.new(params[:comment])
    @comment.owner_id = @current_user.id
    @comment.post_id = params[:post_id]
    @post = Post.find(params[:post_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to post_path(@post), notice: 'An error occurred creating your comment' }
      end
    end
  end

  # PUT /comments/1
  def update
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)

    assert_is_owner_or_admin(@comment.owner_id)

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
      else
        format.html { redirect_to post_path(@post), notice: 'An error occurred saving your comment' }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)

    assert_is_owner_or_admin(@comment.owner_id)

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: 'Comment was successfully deleted.' }
    end
  end
end
