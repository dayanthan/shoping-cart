class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :admin

  def current_user
    # Note: we want to use "find_by_id" because it's OK to return a nil.
    # If we were to use User.find, it would throw an exception if the user can't be found.
    @current_user ||=session[:user]
    # @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  def admin
    @admin = User.find_by_user_email("daya.naukri@gmail.com")
    # @admin = User.find_by_user_type(true)
  end

  def athuenticate?
  	if !session[:user].nil?
    	true
  	else
      flash[:notice]="You must be logged in to access this page"
      redirect_to login_path
  	end
  end
 
end
