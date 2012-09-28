class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  # Use this authentication method for pages that require the user to be logged
  # in. If a user is logged in, set the @current_user variable from their id. If
  # the visitor is not logged in, redirect them to the login page.
  def authenticate_user
    unless session[:user_id] && User.exists?(session[:user_id])
      # If the session user id exists, but the user doesn't,
      # remove the session variable and show an error.
      if session[:user_id]
        session[:user_id] = nil
        session[:search_url] = nil
        flash[:notice] = "Unable to find the logged in user!"
        flash[:color] = "invalid"
      end
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    else
      @current_user = User.find session[:user_id]
      return true
    end
  end

  # Use this authentication method for pages that visitors (people who are not
  # logged in) can view. This method will set @current_user if someone is logged
  # in, but will not redirect them if they are not.
  def authenticate_user_if_logged_in
    if session[:user_id] && User.exists?(session[:user_id])
      @current_user = User.find session[:user_id]
    elsif session[:user_id]
      # If the session user id exists, but the user doesn't,
      # remove the session variable and show an error.
      session[:user_id] = nil
      session[:search_url] = nil
      flash[:notice] = "Unable to find the logged in user!"
      flash[:color] = "invalid"
    end
  end

  # Check to make sure the @current_user is an admin. If not, redirect them with an error
  def assert_is_admin_user
    if @current_user.is_admin?
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
