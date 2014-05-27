class BeveragesController < ApplicationController
  before_action :signed_in_user
  load_and_authorize_resource

  def index
    @search = Beverage.search(params[:q])
    @beverages = @search.result
  end

  def show
  end

  def new
    @beverage = Beverage.new
  end

  def edit
  end

  def create
    # convert_params beverage_params
    @beverage = Beverage.new(beverage_params)

    if @beverage.save
      redirect_to @beverage, notice: t('feedback.created', model: Beverage.model_name.human)
    else
      render action: 'new'
    end
  end

  def update
    if @beverage.update(beverage_params)
      redirect_to @beverage, notice: t('feedback.updated', model: Beverage.model_name.human)
    else
      render action: 'edit'
    end
  end

  def destroy
    @beverage.destroy
    redirect_to action: 'index', notice: t('feedback.destroyed', model: Beverage.model_name.human)
  end

  private
    def beverage_params
      # Transform user input to match the expected format (i.e. 123,0 € => 123.0)
      params[:beverage][:capacity].gsub!(/,/,'.')
      params[:beverage][:capacity].delete!('\s*l$')
      params[:beverage][:price].gsub!(/,/,'.')
      params[:beverage][:price].delete!('€\s')
      params[:beverage][:external_price].gsub!(/,/,'.')
      params[:beverage][:external_price].delete!('€\s')
      params.require(:beverage).permit(:name, :description, :available, :price, :external_price, :capacity)
    end
end
