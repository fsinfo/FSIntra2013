class BeveragesController < ApplicationController
  before_action :set_beverage, only: [:show, :edit, :update]
  before_action :check_permission

  # GET /beverages
  def index
    @beverages = Beverage.all
    respond_to do |format|
      format.html
      format.json { render :json => @beverages.to_json}
    end
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
      redirect_to @beverage, notice: t('feedback.created', model: Beverage.model_name.human)
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /beverages/1
  def update
    # convert_params beverage_params
    if @beverage.update(beverage_params)
      redirect_to @beverage, notice: t('feedback.updated', model: Beverage.model_name.human)
    else
      render action: 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beverage
      @beverage = Beverage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beverage_params
      params[:beverage][:capacity].gsub!(/,/,'.')
      params[:beverage][:price].gsub!(/,/,'.')
      params[:beverage][:price].delete!('€\s')
      params.require(:beverage).permit(:name, :description, :available, :price, :capacity)
    end

    def check_permission
      redirect_to root_url unless (current_user and current_user.has_group?('kuehlschrank')) or authenticate_or_request_with_http_basic {|username, password| HTTP_AUTH_USER == username && HTTP_AUTH_PASSWORD == password}
    end
end
