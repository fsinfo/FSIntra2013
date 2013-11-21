class Minutes::ItemsController < ApplicationController
  before_action :signed_in_user
  load_and_authorize_resource

  before_action :set_minutes_item, only: [:show, :edit, :update, :destroy, :move]
  before_action :set_minute
  respond_to :html, :js

  # GET /minutes/items
  # GET /minutes/items.json
  def index
    @minutes_items = Minutes::Item.all
  end

  # GET /minutes/items/1
  # GET /minutes/items/1.json
  def show
  end

  # GET /minutes/items/new
  def new
    @minutes_item = @minutes_minute.items.build
    #respond_with(:minutes, @minutes_minute, @minutes_item)
    respond_with(@minutes_item)
  end

  # GET /minutes/items/1/edit
  def edit
  end

  # POST /minutes/items
  # POST /minutes/items.json
  def create
    @minutes_item = @minutes_minute.items.build(minutes_item_params)
        
    found = false
    @minutes_minute.items.each do |i|
      # go forward until we find the right 
      if i.id != params[:after_top].to_i and not found
        puts "found is false and #{i.id} != #{params[:after_top]}"
        next
      end

      # we have the right one
      if i.id == params[:after_top].to_i
        puts "found is still false but #{i.id} == #{params[:after_top]}"
        @minutes_item.order = i.order + 1
        found = true
      elsif i.id != params[:after_top].to_i and not i.new_record? # order of other items + 1
        puts "found is now true and #{i.id} != #{params[:after_top]}"
        puts "now i set i.order from #{i.order} to #{i.order + 1}"
        i.update_attributes order: i.order + 1
      end
    end

    respond_to do |format|
      if @minutes_item.save
        format.html { redirect_to @minutes_minute, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @minutes_minute }
      else
        format.html { render action: 'new' }
        format.json { render json: @minutes_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /minutes/items/1
  # PATCH/PUT /minutes/items/1.json
  def update
    respond_to do |format|
      if @minutes_item.update(minutes_item_params)
        format.html { redirect_to @minutes_minute, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @minutes_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /minutes/items/1
  # DELETE /minutes/items/1.json
  def destroy
    @minutes_item.destroy
    respond_to do |format|
      format.html { redirect_to minutes_items_url }
      format.json { head :no_content }
    end
  end

  def move
    if params[:dir] == 'down'
      @minutes_item.move_down
      direction = 'unten'
    else
      @minutes_item.move_up
      direction = 'oben'
    end

    respond_to do |format|
      format.html { redirect_to @minutes_minute, notice: "TOP #{@minutes_item.title} nach #{direction} verschoben." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minutes_item
      @minutes_item = Minutes::Item.find(params[:id])
    end

    def set_minute
      @minutes_minute = Minutes::Minute.find(params[:minute_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def minutes_item_params
      params.require(:minutes_item).permit(:date, :title, :content, :order, :minute_id)
    end
end
