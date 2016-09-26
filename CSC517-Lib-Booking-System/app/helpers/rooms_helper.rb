module RoomsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please Log In."
      redirect_to login_url
    end
  end

  def current_user?(user)
    user == current_user end

  def admin_login
    unless isAdmin?
      flash[:danger] = "Permission Denied! Only Admin Have Authority To Create Users."
      redirect_to(current_user)
    end
  end

end
