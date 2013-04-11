class BeveragesController < ApplicationController
  before_action :set_beverage, only: [:show, :edit, :update, :destroy]

  # GET /beverages
  def index
    @beverages = Beverage.all
  end

  # GET /beverages/1
  def show
  end

  # GET /beverages/new
  def new
    @beverage = Beverage.new
  end

  # GET /beverages/1/edit
  def edit
  end

  # POST /beverages
  def create
    # convert_params beverage_params
    @beverage = Beverage.new(beverage_params)

    if @beverage.save
      redirect_to @beverage, notice: 'Beverage was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /beverages/1
  def update
    # convert_params beverage_params
    if @beverage.update(beverage_params)
      redirect_to @beverage, notice: 'Beverage was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /beverages/1
  def destroy
    @beverage.destroy
    redirect_to beverages_url, notice: 'Beverage was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beverage
      @beverage = Beverage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beverage_params
      params[:beverage][:price].gsub!(/,/,'.')
      params[:beverage][:price].delete!('€a-zA-Z\s')
      params.require(:beverage).permit(:name, :description, :available, :price)
    end
end
