class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if(user.authority == '0')
        log_in user
        redirect_to root_url
      elsif(user.authority == '1' || user.authority == '2')
          log_in user
          redirect_to user #need to change as manager
      else
        flash.now[:danger] = 'Invalid message, please contact admin'
        render "new"
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
    end

  end

  def welcome
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def switch
    log_out
    redirect_to login_path
    flash[:success] = "You Have Successfully Logged Out."
  end
end
