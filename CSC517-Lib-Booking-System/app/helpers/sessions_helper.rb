module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  # return logging user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
# if user has logged in, return true; else return false
  def logged_in?
    !current_user.nil?
  end
  def isUser?
    current_user.authority == '0'
  end
  def isAdmin?
    current_user.authority == '1'
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil end
end
