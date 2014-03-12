class Minutes::PlenumMinutesController < Minutes::MinutesController
  before_action :trim_guests, only: [:update, :create]
  load_and_authorize_resource
  respond_to :html, :json
  
  def new
    @minutes_minute = Minutes::PlenumMinute.new
    respond_with(@minutes_minute)
  end

  # POST /minutes/minutes
  # POST /minutes/minutes.json
  def create
    params[:minutes_plenum_minute][:keeper_of_the_minutes_id] ||= current_user.id
    @minutes_minute = Minutes::PlenumMinute.new(minutes_plenum_minute_params)

    if @minutes_minute.save
      @forward = url_for [:edit, @minutes_minute]      
      respond_with(@minutes_minute, status: :created, :location => @minutes_minute)
    else
      respond_with(@minutes_minute, status: :unprocessable_entity)
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

      #params.require(:minutes_plenum_minute).permit(:date,
      #                                       :keeper_of_the_minutes_id,
      #                                       :chairperson_id,
      #                                       :guests,
      #                                       :has_quorum,
      #                                       :fsr_attendant_ids => [])
    end

    # If someone forgets to remove the last ", "
    def trim_guests
      params[:minutes_plenum_minute][:guests] = params[:minutes_plenum_minute][:guests].chomp(", ")
    end
end
