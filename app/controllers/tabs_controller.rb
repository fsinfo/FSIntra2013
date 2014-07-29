class TabsController < ApplicationController
	before_action :signed_in_user
  load_and_authorize_resource

  def index
    @running_tab = current_user.tabs.running.first
    @unpaid_tabs = current_user.tabs.includes(:user).unpaid
    @paid_tabs = current_user.tabs.includes(:user).paid
  end

  def show
  end

	def new
		tab = Tab.new(status: Tab::STATUS_RUNNING) if current_user.running_tab == nil
		current_user.tabs << tab
		redirect_to edit_tab_path(tab)
	end

  def detail
  end

  def update
    if @tab.update(tab_params)
      redirect_to tabs_path, notice: t('feedback.updated', model: Tab.model_name.human)
    else
      render action: 'edit'
    end
  end

  def edit
    @beverage_tabs = @tab.beverage_tabs
		@beverages = Beverage.available
  end

  def pay
    @tab.paid
    if @tab.save
      redirect_to @tab
		else
			render @tab
    end
  end

	def add_beverage
			@beverage = Beverage.find(params[:beverage_id])
			@tab.beverage_tabs << BeverageTab.create(count: 1, name: @beverage.name, capacity: @beverage.capacity, price: @beverage.price)
			if @tab.save
				redirect_to edit_tab_path(@tab), notice: t('feedback.updated', model: Tab.model_name.human)
			else
				redirect_to edit_tab_path(@tab)
			end
	end

  def unpaid
    @tabs = Tab.unpaid.includes(:user, :beverage_tabs).order("people.lastname")
		@users = User.includes(:tabs).where(tabs: {status: Tab::STATUS_UNPAID}).distinct.map{|u| u.to_s} + ['bezahlt']
		@sum = @tabs.inject(0.0) {|sum, tab| sum += tab.total_invoice}
  end

	def running
		@tabs = Tab.running
		@users = User.includes(:tabs).where(tabs: {status: Tab::STATUS_RUNNING}).distinct.map{|u| u.to_s}
	end

  private
    def tab_params
      params.require(:tab).permit(:paid, :status, { :beverage_tabs_attributes => [:id, :count] } )
    end
end
