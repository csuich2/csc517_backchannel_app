class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_filter :authenticate_user, :only => [:index, :destroy, :make_admin, :revoke_admin]
  before_filter :assert_is_admin_user, :only => [:index, :destroy, :make_admin, :revoke_admin]

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
    else
      flash[:notice] = "Form is invalid"
      flash[:color] = "invalid"
    end
    render "new"
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])

    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  def make_admin
    @user = User.find(params[:id])

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

    @user.is_admin = false

    if @user.save
      flash[:notice] = "#{@user.username} has been granted admin access."
      flash[:color] = "valid"
    else
      flash[:notice] = "An error occurred granting admin access."
      flash[:color] = "error"
    end

    redirect_to users_url
  end
end

