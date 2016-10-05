class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :new, :destroy]
  before_action :correct_user_show, only: [:show]
  #user cannot see other's info, admin can
  before_action :correct_user_edit, only:[:edit, :update]
  #admin and user cannot edit other's info
  before_action :admin_login, only: [:new, :destroy, :index]

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
      if logged_in?
        if @user.save
          format.html { redirect_to @user }
          format.json { render :show, status: :created, location: @user }
          flash[:success] = "User Was Successfully Created."
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        if @user.save
          format.html { redirect_to login_path }
          format.json { render :login_path, status: :created }
          flash[:success] = "User Was Successfully Created."
        else
          format.html { render :sign_up }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
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
    if @user.authority == '2'
      flash[:danger] = 'Pre-configured Admin Cannot Be Deleted'
      redirect_to users_path
    elsif @user.email == current_user.email
      flash[:danger] = 'Oops. Don\'t Delete Yourself'
      redirect_to users_path
    else
      sql = "delete from histories where email = '#{@user.email}' and (date > '#{Time.now.to_date}' or (date = '#{Time.now.to_date}' and begintime > '#{Time.now.hour}' ))"
      h = History.find_by_sql(sql)
      @user.destroy
      redirect_to users_path
      flash[:success] = 'User Was Successfully Deleted'
    end
  end

  # show history
  def showhistory
  end

  # member sign up
  def sign_up
    @user = User.new
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
