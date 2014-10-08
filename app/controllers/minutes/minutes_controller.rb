class Minutes::MinutesController < ApplicationController
  before_action :signed_in_user, except: [:public, :public_show]
  load_and_authorize_resource except: [:public, :public_show]

  before_action :set_minutes_minute, only: [:show, :edit, :update, :destroy, :send_draft, :publish]
  before_action :trim_guests, only: [:update, :create]
  respond_to :html, :json

  # GET /minutes/minutes
  # GET /minutes/minutes.json
  def index
    @open_minutes = Minutes::Minute.includes(:keeper_of_the_minutes, :chairperson).open.order(date: :desc)
    @released_minutes = Minutes::Minute.includes(:keeper_of_the_minutes, :chairperson).released.order(date: :desc)
    @accepted_minutes = Minutes::Minute.includes(:keeper_of_the_minutes, :chairperson).accepted.order(date: :desc)
  end

  def public
    @minutes = Minutes::Minute.accepted.order(date: :desc)
  end

  def public_show
    @minutes_minute = Minutes::Minute.includes(items: [motions: [:mover]]).find(params[:id])
    render 'show'
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
    params[:minutes_minute][:keeper_of_the_minutes_id] ||= current_user.id
    @minutes_minute = Minutes::Minute.new(minutes_minute_params)

    if @minutes_minute.save
      @forward = url_for [:edit, @minutes_minute]

      # Default items
      order_counter = 0
      ["Mitteilungen", "Verschiedenes"].each do |item|
        @minutes_minute.items.create title: item, order: order_counter, content: ''
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
        format.html { redirect_to @minutes_minute, notice: 'Protokoll erfolgreich bearbeitet.' }
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
      format.html { redirect_to minutes_minutes_url, notice: 'Protokoll erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  def send_draft
    @minutes_minute.update_attributes({ draft_sent_date: Date.today })

    if @minutes_minute.type == "Minutes::PlenumMinute"
      m = PlenumMinuteMailer.send_draft(@minutes_minute, @minutes_minute.keeper_of_the_minutes)
    else
      ### DARUNTER
      m = MinuteMailer.send_draft(@minutes_minute, @minutes_minute.keeper_of_the_minutes)
      ### DARÜBER
    end
    m.deliver
    
    respond_to do |format|
      format.html { redirect_to @minutes_minute, notice: 'Entwurf erfolgreich verschickt.' }
      format.json { head :no_content }
    end
  end

  def publish
    @minutes_minute.update_attributes({ released_date: Date.today })

    if @minutes_minute.type == "Minutes::PlenumMinute"
      PlenumMinuteMailer.publish(@minutes_minute, @minutes_minute.keeper_of_the_minutes).deliver
    else
      MinuteMailer.publish(@minutes_minute, @minutes_minute.keeper_of_the_minutes).deliver
    end

    respond_to do |format|
      format.html { redirect_to @minutes_minute, notice: 'Protokoll erfolgreich verschickt.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minutes_minute
      @minutes_minute = Minutes::Minute.includes(items: [motions: [:mover]]).find(params[:id])
    end

    def minutes_minute_params
      params.require(:minutes_minute).permit(:date,
                                             :keeper_of_the_minutes_id,
                                             :chairperson_id,
                                             :guests,
                                             :has_quorum,
                                             :fsr_attendant_ids => [])
    end

    # If someone forgets to remove the last ", "
    def trim_guests
      params[:minutes_minute][:guests] = params[:minutes_minute][:guests].chomp(", ")
    end
end
