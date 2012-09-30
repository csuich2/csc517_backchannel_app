class PostsController < ApplicationController
  before_filter :authenticate_user, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user_if_logged_in, :except => [:new, :edit, :create, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all

    session[:search_url] = nil

    @posts.sort! {|x,y| x.latest_timestamp <=> y.latest_timestamp}
    @posts.reverse!

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])

    @comments = Comment.find_all_by_post_id(@post.id)
    @comments.sort! {|x,y| x.latest_timestamp <=> y.latest_timestamp}
    @comments.reverse!

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

    if assert_is_owner_or_admin(@post.user)
      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])

    if assert_is_owner_or_admin(@post.user)

      @post.destroy

      respond_to do |format|
        format.html {
          unless session[:search_url]
            redirect_to posts_url
          else
            redirect_to session[:search_url]
          end
        }
      end
    end
  end

  def search_by_category
    @posts = Category.search(params[:search][:category_id])
    session[:search_url] = request.url
    render "search_results"
  end

  def search_by_content
    @posts = Post.search(params[:search][:search])
    session[:search_url] = request.url
    render "search_results"
  end

  def search_by_user
    @posts = User.search(params[:search][:search])
    session[:search_url] = request.url
    render "search_results"
  end

  def who_voted
    @post = Post.find(params[:id])

    render "who_voted"
  end
end
