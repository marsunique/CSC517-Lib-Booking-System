class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]

  # GET /histories
  # GET /histories.json
  def index
    @histories = History.all
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # Show my history of booking room
  def showmine
    sql = "select *from histories where email = '#{current_user.email}'"
    @histories = History.find_by_sql(sql)
  end

  #show a person's history
  #def showother
  #  sql = "select *from histories where email = '#{params[:email]}'"
  #  @histories = History.find_by_sql(sql)
  #end

  def show_user_history
    @userhistory = History.where(email: params[:email])
  end

  def show_room_history
    @roomhistory = History.where(number: params[:number], building: params[:building])
  end

  # GET /histories/new
  def new
    @history = History.new
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(history_params)
    if @history.date == 'None'
      flash.now[:danger] = 'Please Select A Date'
      render "new"
    else
      if(@history.date == "#{Time.now.to_date}") #judge if it is today
        if(@history.begintime < "#{Time.now.hour+1}")  #judge if the time has passed
          flash.now[:danger] = 'This Time Has Passed, Please Select Another Time'
          render "new"
        else
          sql = "select number from rooms where building = '#{@history.building}' and number = '#{@history.number}'"
          t = Room.find_by_sql(sql)
          if t[0].nil? #room data is invalid
            if @history.number == '' #didn't enter a room number
              flash.now[:danger] = 'Please Enter A Room Number'
              render "new"
            else
              flash.now[:danger] = 'No Such Room'
              render "new"
            end
          else #room is existed
            sql = "select email from users where email = '#{@history.email}' "
            t = User.find_by_sql(sql)
            if t[0].nil? #user data is invalid
              flash.now[:danger] = 'No Such User'
              render "new"
            else #user is existed
              sql = "select id from histories where building = '#{@history.building}' and number = '#{@history.number}' and date = '#{@history.date}' and begintime = '#{@history.begintime}'"
              h = History.find_by_sql(sql)
              if !h[0].nil? #has been lent
                flash.now[:danger] = 'This Room Has Already Been Booked At Selected Time'
                render "new"
              else
                respond_to do |format|
                  if @history.save
                    format.html { redirect_to @history }
                    format.json { render :show, status: :created, location: @history }
                    flash[:success] = "Room Was Successfully Booked"
                  else
                    format.html { render :new }
                   format.json { render json: @history.errors, status: :unprocessable_entity }
                  end
                end
              end
            end
          end
        end
      else # it's not today
        sql = "select number from rooms where building = '#{@history.building}' and number = '#{@history.number}'"
        t = Room.find_by_sql(sql)
        if t[0].nil? #room data is invalid
          if @history.number == '' #didn't enter a room number
            flash.now[:danger] = 'Please Enter A Room Number'
            render "new"
          else
            flash.now[:danger] = 'No Such Room'
            render "new"
          end
        else #room is existed
          sql = "select email from users where email = '#{@history.email}' "
          t = User.find_by_sql(sql)
          if t[0].nil? #user data is invalid
            flash.now[:danger] = 'No Such User'
            render "new"
          else #user is existed
            sql = "select id from histories where building = '#{@history.building}' and number = '#{@history.number}' and date = '#{@history.date}' and begintime = '#{@history.begintime}'"
            h = History.find_by_sql(sql)
            if !h[0].nil? #has been lent
              flash.now[:danger] = 'This Room Has Already Been Booked At Selected Time'
              render "new"
            else
              respond_to do |format|
                if @history.save
                  format.html { redirect_to @history }
                  format.json { render :show, status: :created, location: @history }
                  flash[:success] = 'Room Was Successfully Booked'
                else
                  format.html { render :new }
                  format.json { render json: @history.errors, status: :unprocessable_entity }
                end
              end
            end
          end
        end
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history }
        format.json { render :show, status: :ok, location: @history }
        flash[:success] = 'Booking Info Was Successfully Updated'
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    if(@history.date == "#{Time.now.to_date}") #judge if it is today
      if(@history.begintime < "#{Time.now.hour+0}")  #judge if the time has passed
        flash[:danger] = 'The Reservation Has Begun, Cannot Cancel It.'
        @histories = History.all
        if isAdmin?
          redirect_to histories_path
        else
          redirect_to showmine_path
        end
      else
        @history.destroy
        flash[:success] = 'Reservation Is Cancelled'
        if isAdmin?
          redirect_to histories_path
        else
          redirect_to showmine_path
        end
      end
    elsif(@history.date > "#{Time.now.to_date}")
      @history.destroy
      flash[:success] = 'Reservation Is Cancelled'
      if isAdmin?
        redirect_to histories_path
      else
        redirect_to showmine_path
      end
    else
      flash[:danger] = 'Request Denied. This Date Has Passed.'
      if isAdmin?
        redirect_to histories_path
      else
        redirect_to showmine_path
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:number, :building, :email, :date, :begintime, :endtime)
      #params[:history][:email] = params[:session][:password]
    end
end
