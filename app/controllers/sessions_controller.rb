class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  #def login
    # Login Form
  #end

  def login_attempt
    authorized_user = User.authenticate(params[:username], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      uname = authorized_user.username
      flash[:notice] = "Welcome, #{authorized_user.username}!"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid username!"
      flash[:color] = "invalid"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    session[:search_url] = nil
    redirect_to :action => 'login'
  end

  #def home
  #end
end
