class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :new, :creat, :destroy]
  before_action :correct_user_show, only: [:show]
  #user cannot see other's info, admin can
  before_action :correct_user_edit, only:[:edit, :update]
  #admin and user cannot edit other's info
  before_action :admin_login, only: [:new, :create, :destroy, :index]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User info was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    #unless @user.update(user_params)
      #respond_to do /format/
        #format.html { render :edit }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      #end
    #else
      #redirect_to @user
      #flash[:success] = 'User Info Was Successfully Updated.'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    unless @user.authority == '2'
      @user.destroy
    #respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      #format.json { head :no_content }
    #end
    redirect_to users_url
    flash[:success] = 'User was successfully deleted'
    end
  end

  # show history
  def showhistory
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :authority)
    end
end
