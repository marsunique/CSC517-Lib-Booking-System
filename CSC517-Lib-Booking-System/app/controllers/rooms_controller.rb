class RoomsController < ApplicationController
  include RoomsHelper
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :new, :creat, :destroy]
  before_action :admin_login, only: [:new, :create, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
    if params[:searchNumber] == ''  && params[:searchSize] == '' && params[:searchBuilding] == ''
      @rooms = Room.all.order('created_at DESC')
    else
      @rooms = Room.search(params[:searchNumber], params[:searchSize], params[:searchBuilding])
    end
    #elsif params[:searchSize] != ''
      #@rooms = Room.searchSize(params[:searchSize])
    #else
    #end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    sql = "select id from rooms where building = '#{@room.building}' and number = '#{@room.number}' "
    h = Room.find_by_sql(sql)
    if !h[0].nil? # Room is already existed
      flash.now[:danger] = 'Room Already Existed'
      render "new"
    else # Room dosen't exist
      respond_to do |format|
        if @room.save
          format.html { redirect_to @room }
          format.json { render :show, status: :created, location: @room }
          flash[:success] = 'Room Was Successfully Created'
        else
          format.html { render :new }
         format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room }
        format.json { render :show, status: :ok, location: @room }
        flash[:success] = 'Room Was Successfully Updated'
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    flash[:success] = 'Room Is Successfully Deleted'
    redirect_to rooms_path
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:number, :size, :building)
    end
end
