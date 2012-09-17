class PostsController < ApplicationController
  before_filter :authenticate_user

  # GET /posts
  def index
    @posts = Post.all

    # TODO fancy sorting logic
    # TODO sort by: this timestamp && latest comment timestamp

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /posts/new
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    assert_is_owner_or_admin(@post.user)
  end

  # POST /posts
  def create
    @post = Post.new(params[:post])

    # TODO can we move this into the post object? When I tried, @current_user was nil in the before_save callback
    @post.user = @current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, :notice => 'Post was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /posts/1
  def update
    @post = Post.find(params[:id])

    assert_is_owner_or_admin(@post.user)

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])

    assert_is_owner_or_admin(@post.user)

    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
    end
  end

end
