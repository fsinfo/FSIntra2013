class MinutesController < ApplicationController
  before_action :set_minute, only: [:show, :edit, :update, :destroy, :publish]

  # GET /minutes
  # GET /minutes.json
  def index
    @minutes = Minute.order ('date DESC')
  end

  # GET /minutes/1
  # GET /minutes/1.json
  # GET /minutes/1.pdf
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = MinutePdf.new(@minute, view_context)
        send_data pdf.render, filename: "TODO_Protokollnamenüberlegen.pdf", type: "application/pdf", disposition: inline
      end
    end
  end

  # GET /minutes/new
  def new
    @minute = Minute.new

    order_counter = 0
    @minute.build_minute_approve_item
    ["Festlegung der Tagesordnung", "Mitteilungen", "Anträge", "Verschiedenes"].each do |item|
      new_item = @minute.items.build
      new_item.title = item
      new_item.order = order_counter
      order_counter += 1
    end

    set_approvable_minutes
  end

  # GET /minutes/1/edit
  def edit
    if @minute.minute_approve_item.nil?
      @minute.build_minute_approve_item
    end
    set_approvable_minutes
  end

  # POST /minutes
  # POST /minutes.json
  def create
    @minute = Minute.new(minute_params)
    respond_to do |format|
      if @minute.save
        format.html { redirect_to @minute, notice: t('feedback.created', :model => Minute.model_name.human) }
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
    @minute.unpublish
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

  # PUT /minutes/1/publish
  def publish
    @minute.publish
    respond_to do |format|
      if @minute.save
        format.html { redirect_to @minute, notice: 'Protokoll veröffentlicht' }
        format.json { head :no_content }
      else
        format.html { redirect_to @minute, notice: 'Protokoll nicht veröffentlicht :(' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minute
      @minute = Minute.find(params[:id])
    end


    # sets the @approvable_minutes member variable
    # note that this requires an existing @minute object
    # and should therefore not be called via before_actions
    def set_approvable_minutes
      # we "pre build" the approvable minutes
      puts "\n\nD E B U G G I N G\n\n"

      if @minute.persisted?
        # don't approve yourself
        @approvable_minutes = Minute.approvable.where.not(:id => @minute.id)
        puts "Was persisted"
      else
        @approvable_minutes = Minute.approvable
        puts "Was not persisted"
      end

      puts @approvable_minutes

      @minute.minute_approve_item.minute_approve_motions.map { |x| x.minute }.inspect

      
      # these minutes are already in this protocoll
      @approvable_minutes -= @minute.minute_approve_item.minute_approve_motions.map { |x| x.minute }

      @approvable_minutes.each do |m|
        motion = @minute.minute_approve_item.minute_approve_motions.build
        motion.minute = m
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def minute_params
      params.require(:minute).permit(:date,
                                     :keeper_of_the_minutes_id,
                                     :chairperson_id,
                                     {
                                        :items_attributes => [
                                          :id,
                                          :_destroy,
                                          :title,
                                          :content,
                                          :order,
                                          {:motions_attributes => [
                                              :id,
                                              :_destroy,
                                              :rationale,
                                              :mover_id,
                                              :pro,
                                              :abs,
                                              :con ]
                                          }
                                        ],
                                        :minute_approve_item_attributes => [
                                          :id,
                                          {:minute_approve_motions_attributes => [
                                              :id,
                                              :pro,
                                              :abs,
                                              :con,
                                              :approved,
                                              :minute_id
                                              ]}
                                        ]
                                      })
    end
end