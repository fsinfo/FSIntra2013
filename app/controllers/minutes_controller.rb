class MinutesController < ApplicationController
  before_action :set_minute, only: [:show, :edit, :update, :destroy, :publish, :accept]
  before_action :set_acceptable_minutes, only: [:new, :create, :edit, :update]
  #before_action :extract_approved_minutes, only: [:create, :update]

  # GET /minutes
  # GET /minutes.json
  def index
    @minutes = Minute.all
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

    @acceptable_minutes = Minute.published.where.not(:id => @minute.id)
  end

  # GET /minutes/1/edit
  def edit
    @acceptable_minutes = Minute.published.where.not(:id => @minute.id)
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

    def set_acceptable_minutes
      if @minute
        @acceptable_minutes = Minute.published.where.not(:id => @minute.id)
      else
        @acceptable_minutes = Minute.published
      end
    end

    # Replace the ids with the right user object (if id is present)
    def users_to_ids
      params[:minute][:keeper_of_the_minutes] = User.find_by_id(params[:minute][:keeper_of_the_minutes])
      params[:minute][:chairperson] = User.find_by_id(params[:minute][:chairperson])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def minute_params

      puts params

      #params.require(:minute).permit(:date, :keeper_of_the_minutes_id, :chairperson_id,
      #                               :items_attributes => [:id, :title, :content, :order,
      #                               :minutes_motion_attributes => [:rationale, :mover_id, :pro, :abs, :con]])
      params.require(:minute).permit(:date,
                                     :keeper_of_the_minutes_id,
                                     :chairperson_id,
                                     {
                                        :items_attributes => [
                                          :id,
                                          :title,
                                          :content,
                                          :order,
                                          {:motions_attributes => [
                                              :id,
                                              :rationale,
                                              :mover_id,
                                              :pro,
                                              :abs,
                                              :con ]
                                          }
                                        ]
                                      })
    end

    def extract_approved_minutes
      the_item = @minute.build_minute_approve_item
      params[:minute][:minutes_minute_approve_item].each_pair do |k, v|
        motion = the_item.minute_approve_motions.build
        motion.minute = Minute.find(k)
        motion.pro = v[:pro]
        motion.abs = v[:abs]
        motion.con = v[:con]
      end
    end
end