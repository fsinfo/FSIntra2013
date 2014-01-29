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

    puts "\n\n\n"
    puts @plenum_minute.inspect
    puts "\n\n\n"

    if @plenum_minute.save
      @forward = url_for [:edit, @plenum_minute]      
      puts '##########'
      puts 'SAVED'
      puts '##########'
      respond_with(@plenum_minute, status: :created, :location => @plenum_minute)
    else
      puts '##########'
      puts 'NOT SAVED'
      puts '##########'
      respond_with(@plenum_minute, status: :unprocessable_entity)
    end
  end

  private

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
