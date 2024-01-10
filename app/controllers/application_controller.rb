class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def current_user
    #from the sessions controller we grab the user id: session[:user_id]
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    else
      puts "User is logged in." # Add this line
    end
  end

end
