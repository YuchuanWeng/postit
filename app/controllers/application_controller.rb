class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  #this helper_method help the following two method available also in the tempaltes

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #if current user exist, then the right side won't be executed
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must log in."
      redirect_to root_path
    end
  end
end
