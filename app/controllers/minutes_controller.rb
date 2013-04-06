class MinutesController < ApplicationController
  before_action :set_minute, only: [:show, :edit, :update, :destroy]

  # GET /minutes
  # GET /minutes.json
  def index
    @minutes = Minute.all
  end

  # GET /minutes/1
  # GET /minutes/1.json
  def show
  end

  # GET /minutes/new
  def new
    @minute = Minute.new
  end

  # GET /minutes/1/edit
  def edit
  end

  # POST /minutes
  # POST /minutes.json
  def create
    @minute = Minute.new(minute_params)

    respond_to do |format|
      if @minute.save
        format.html { redirect_to @minute, notice: 'Minute was successfully created.' }
        format.json { render action: 'show', status: :created, location: @minute }
      else
        format.html { render action: 'new' }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /minutes/1
  # PATCH/PUT /minutes/1.json
  def update
    respond_to do |format|
      if @minute.update(minute_params)
        format.html { redirect_to @minute, notice: 'Minute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /minutes/1
  # DELETE /minutes/1.json
  def destroy
    @minute.destroy
    respond_to do |format|
      format.html { redirect_to minutes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minute
      @minute = Minute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def minute_params
      params.require(:minute).permit(:date, :status)
    end
end
