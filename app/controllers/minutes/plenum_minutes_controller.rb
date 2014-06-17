class Minutes::PlenumMinutesController < Minutes::MinutesController
  before_action :trim_guests, only: [:update, :create]
  respond_to :html, :json
  
  def new
    respond_with(@plenum_minute)
  end

  # POST /minutes/minutes
  # POST /minutes/minutes.json
  def create
    params[:minutes_plenum_minute][:keeper_of_the_minutes_id] ||= current_user.id
    @plenum_minute = Minutes::PlenumMinute.new(minutes_plenum_minute_params)

    if @plenum_minute.save
      @forward = url_for [:edit, @plenum_minute]      
      @plenum_minute.items.create title: 'Mitteilungen', order: 0, content: ''
      respond_with(@plenum_minute, status: :created, :location => @plenum_minute)
    else
      respond_with(@plenum_minute, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /minutes/minutes/1
  # PATCH/PUT /minutes/minutes/1.json
  def update
    respond_to do |format|
      if @plenum_minute.update(minutes_plenum_minute_params)
        format.html { redirect_to @plenum_minute, notice: 'Protokoll erfolgreich bearbeitet.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @plenum_minute.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_minutes_minute
      @minutes_minute = Minutes::PlenumMinute.find(params[:id])
    end

    def minutes_plenum_minute_params
      params.require(:minutes_plenum_minute).permit(:date,
                                             :chairperson_id,
                                             :keeper_of_the_minutes_id,
                                             :guests)
    end

    # If someone forgets to remove the last ", "
    def trim_guests
      params[:minutes_plenum_minute][:guests] = params[:minutes_plenum_minute][:guests].chomp(", ")
    end
end
