class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  # If a user is logged in, set the @current_user variable from their id
  def authenticate_user
    unless session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    else
      @current_user = User.find session[:user_id]
      return true
    end
  end

  # Check to make sure the @current_user is an admin. If not, redirect them with an error
  def assert_is_admin_user
    if @current_user.is_admin
      return true
    else
      flash[:notice] = "You are not authorized to view that page."
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    end
  end

  # Check to make sure the @current_user is the same as the input owner. If not, redirect them with an error
  def assert_is_owner_or_admin(owner)
    # By owner, we mean the user who owns some item
    if @current_user.id == owner.id || @current_user.is_admin
      return true
    else
      flash[:notice] = "You are not authorized to view that page."
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    end
  end

  # Redirect to home if the user is logged in already
  def save_login_state
    if session[:user_id]
      redirect_to(:controller =>  'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
