class Minutes::MinutesController < ApplicationController
  before_action :set_minutes_minute, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # GET /minutes/minutes
  # GET /minutes/minutes.json
  def index
    @minutes_minutes = Minutes::Minute.all
  end

  # GET /minutes/minutes/1
  # GET /minutes/minutes/1.json
  def show
  end

  # GET /minutes/minutes/new
  def new
    @minutes_minute = Minutes::Minute.new
    respond_with(@minutes_minute)
  end

  # GET /minutes/minutes/1/edit
  def edit
  end

  # POST /minutes/minutes
  # POST /minutes/minutes.json
  def create
    @minutes_minute = Minutes::Minute.new(minutes_minute_params)

    if @minutes_minute.save
      @forward = url_for [:edit, @minutes_minute]

      # Default items
      order_counter = 0
      ["Festlegung der Tagesordnung", "Mitteilungen", "Anträge", "Verschiedenes"].each do |item|
        new_item = @minutes_minute.items.create title: item, order: order_counter
        order_counter += 1
      end
      
      respond_with(@minutes_minute, status: :created, :location => @minutes_minute)
    else
      respond_with(@minutes_minute, status: :unprocessable_entity)
    end
    #respond_to do |format|
    #  if @minutes_minute.save
    #    format.html { redirect_to @minutes_minute, notice: 'Minute was successfully kreiert.' }
    #    format.json
    #  else
    #    format.html { render action: 'edit' }
    #    format.json { render json: @minutes_minute, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /minutes/minutes/1
  # PATCH/PUT /minutes/minutes/1.json
  def update
    respond_to do |format|
      if @minutes_minute.update(minutes_minute_params)
        format.html { redirect_to @minutes_minute, notice: 'Minute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @minutes_minute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /minutes/minutes/1
  # DELETE /minutes/minutes/1.json
  def destroy
    @minutes_minute.destroy
    respond_to do |format|
      format.html { redirect_to minutes_minutes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minutes_minute
      @minutes_minute = Minutes::Minute.find(params[:id])
    end

    def minutes_minute_params
      params.require(:minutes_minute).permit(:date,
                                             :keeper_of_the_minutes_id,
                                             :chairperson_id,
                                             :has_quorum,
                                             :attendant_ids => [])
    end
end
