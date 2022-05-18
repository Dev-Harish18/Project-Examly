module ApplicationHelper
  
  def session_link
    if logged_in?
      link_to("Logout", users_logout_path, method: :delete, class:"nav-link")
    else
      link_to("Login", users_login_path, class:"nav-link")
    end
  end

end
