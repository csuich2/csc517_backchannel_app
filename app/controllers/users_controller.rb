# The following site was used as a tutorial/basis for developing our user authentication system:
# http://rubysource.com/rails-userpassword-authentication-from-scratch-part-i/
class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_filter :authenticate_user, :only => [:index, :destroy, :make_admin, :revoke_admin, :votes]
  before_filter :assert_is_admin_user, :only => [:index, :destroy, :make_admin, :revoke_admin, :votes]

  # GET /users
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color] = "valid"
      session[:user_id] = @user.id
      redirect_to :controller => :sessions, :action => :home
    else
      flash[:notice] = "Form is invalid"
      flash[:color] = "invalid"
      render 'new'
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])

    # Make sure a user does not try to delete their self
    if (@user == @current_user)
      redirect_to users_url
      return
    end

    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  def make_admin
    @user = User.find(params[:id])

    # Make sure a user does not try to grant their self admin access
    if (@user == @current_user)
      redirect_to users_url
      return
    end

    @user.is_admin = true

    if @user.save
      flash[:notice] = "#{@user.username} has been granted admin access."
      flash[:color] = "valid"
    else
      flash[:notice] = "An error occurred granting admin access."
      flash[:color] = "error"
    end

    redirect_to users_url
  end

  def revoke_admin
    @user = User.find(params[:id])

    # Make sure a user does not try to revoke their admin access
    if (@user == @current_user)
      redirect_to users_url
      return
    end

    @user.is_admin = false

    if @user.save
      flash[:notice] = "#{@user.username}'s admin rights have been revoked."
      flash[:color] = "valid"
    else
      flash[:notice] = "An error occurred revoking admin access."
      flash[:color] = "error"
    end

    redirect_to users_url
  end

  # POST /users/votes/1
  def votes
    @user = User.find(params[:id])

    render "votes"
  end
end

