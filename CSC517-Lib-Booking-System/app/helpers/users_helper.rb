module UsersHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please Log In."
      redirect_to login_url
    end
  end

  def correct_user_show
    @user = User.find(params[:id])
    unless current_user?(@user) || isAdmin?
      redirect_to(current_user)
      flash[:danger] = "Naughty! Cannot See Other's Info"
    end
    #redirect_to(root_url) unless current_user?(@user)
  end

  def correct_user_edit
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to(current_user)
      flash[:danger] = "Permission Denied! You Can't Edit Other's Info"
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
  def get_current_email(user)
    return user.email
  end

end
