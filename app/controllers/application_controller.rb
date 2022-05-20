class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?
  rescue_from ActionController::RoutingError, :with => :error_render_method

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to users_login_path
    end
  end

  def error_render_method
    debugger
    render 'layouts/error'
  end
end
