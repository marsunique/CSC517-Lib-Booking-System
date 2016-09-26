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
    if(@history.date == "#{Time.now.to_date}") #judge if it is today
      if(@history.begintime < "#{Time.now.hour+1}")  #judge if the time has passed
        flash.now[:danger] = 'invalid time'
        render "new"
      end
    else # time is valid
      sql = "select number from rooms where building = '#{@history.building}' and number = '#{@history.number}'"
      t = Room.find_by_sql(sql)
      if t[0].nil? #room data is invalid
        flash.now[:danger] = 'no such room'
        render "new"
      else #room is existed
        sql = "select id from histories where building = '#{@history.building}' and number = '#{@history.number}' and date = '#{@history.date}' and begintime = '#{@history.begintime}'"
        h = History.find_by_sql(sql)
        if !h[0].nil? #has been lent
          flash.now[:danger] = 'The time is unavailable'
          render "new"
        else
          respond_to do |format|
            if @history.save
              format.html { redirect_to @history, notice: 'History was successfully created.' }
              format.json { render :show, status: :created, location: @history }
            else
              format.html { render :new }
              format.json { render json: @history.errors, status: :unprocessable_entity }
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
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
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
        flash.now[:danger] = 'The reservation begins, you cannot do anything about it'
        @histories = History.all
        render "showmine"
      else
        @history.destroy
        respond_to do |format|
          format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    elsif(@history.date > "#{Time.now.to_date}")
      @history.destroy
      respond_to do |format|
        format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
        format.json { head :no_content }
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
