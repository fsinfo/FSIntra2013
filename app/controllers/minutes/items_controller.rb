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
    # If this is the first item in the minute
    if @minutes_minute.items == []
      params[:minutes_item][:order] = 0
      params[:after_top] = -1
    end
    @minutes_item = @minutes_minute.items.build(minutes_item_params)

    @minutes_item.order = params[:after_top].to_i + 1
    adjust_items_by 1, params[:after_top].to_i

    respond_to do |format|
      if ActiveRecord::Base.transaction do
          puts "Starting Transaction with #{@updated_items.count} items"
          puts " Neues Item: #{@minutes_item.order}"
          @minutes_item.save
          @updated_items.each do |i|
            puts "  Verschobenes Item #{i.title}: #{i.order}"
            i.save
          end
        end
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
    # adjust later items
    adjust_items_by -1, @minutes_item.order

    ActiveRecord::Base.transaction do
      puts "Starting Transaction with #{@updated_items.count} items"
      @minutes_item.destroy!
      @updated_items.each{|i| i.save! ; puts "#{i.title} saved"}
    end
    respond_to do |format|
      format.html { redirect_to @minutes_minute, notice: 'Item was successfully destroyed.' }
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

    # All items with order <= start are left
    # All items wit horder > start are incremented by amount
    # 
    def adjust_items_by amount, start
      puts "==============="
      puts "adjust_items_by"
      puts "==============="
      puts "amount: #{amount}; start: #{start}"

      @updated_items = []
      @minutes_minute.items.each do |i|
        puts "* #{i.title} -- #{i.order}"
        if not i.new_record? and i.order > start
          puts "  updated"
          i.order += amount
          @updated_items << i
        end
      end
    end
end
