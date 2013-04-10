class MinutesController < ApplicationController
  before_action :set_minute, only: [:show, :edit, :update, :destroy]
  #before_action :users_to_ids, only: [:update]

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

    count = params[:number_of_items].to_i

    respond_to do |format|
      if count > 0 and @minute.save
        count.times do
          @minute.items.create
        end
        format.html { redirect_to edit_minute_path(@minute), notice: t('feedback.created', :model => Minute.model_name.human) }
        format.json { render action: 'edit', status: :created, location: @minute }
      else
        format.html { render action: 'new', notice: 'größerezalh' }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /minutes/1
  # PATCH/PUT /minutes/1.json
  def update
    puts "\n\n\n *** \n\n\n "
    puts @minute
    puts "\n\n\n *** \n\n\n "
    respond_to do |format|
      if @minute.update(minute_params)
        format.html { redirect_to @minute, notice: t('feedback.updated', :model => Minute.model_name.human) }
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
      format.html { redirect_to minutes_url, notice: t('feedback.destroyed', :model => Minute.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minute
      @minute = Minute.find(params[:id])
    end

    # Replace the ids with the right user object (if id is present)
    def users_to_ids
      params[:minute][:keeper_of_the_minutes] = User.find_by_id(params[:minute][:keeper_of_the_minutes])
      params[:minute][:chairperson] = User.find_by_id(params[:minute][:chairperson])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def minute_params
      params.require(:minute).permit(:date, :keeper_of_the_minutes_id, :chairperson_id, :items_attributes => [:id, :title, :content])
    end
end
