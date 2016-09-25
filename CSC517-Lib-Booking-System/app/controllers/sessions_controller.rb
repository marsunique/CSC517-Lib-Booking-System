class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase, authority: '1')
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user #need to change as manager

    else
      user = User.find_by(email: params[:session][:email].downcase, authority: '0')
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to user
      else
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
      end

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
