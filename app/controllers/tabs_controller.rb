class TabsController < ApplicationController
	before_action :set_tab, only: [:update, :new, :show, :edit, :pay, :mark_as_paid]
	before_action :signed_in_user
  before_action :correct_user, only: [:show, :mark_as_paid]
	before_action :has_permission, only: [:update, :unpaid, :pay, :edit]

	def index
    @running_tab = current_user.tabs.running
		@unpaid_tabs = current_user.tabs.unpaid
		@paid_tabs = current_user.tabs.paid
	end

	def show
		@beverage_tabs = @tab.beverage_tabs
	end

	def update
    if @tab.update(tab_params)
      redirect_to @tab, notice: 'Tab was successfully updated.'
    else
      render action: 'edit'
    end
	end

	def edit
		@beverage_tabs = @tab.beverage_tabs
	end

	def pay
		@tab.paid
		@user = @tab.user
		TabMailer.paid_email(@tab) if @tab.save
		render :nothing => true
	end

  def mark_as_paid
    @tab.status = 'marked_as_paid'
    TabMailer.marked_as_paid_email(@tab) if @tab.save
    render :nothing => true
  end

	def unpaid
		@tabs = Tab.unpaid.joins(:user).includes(:beverage_tabs).order('people.firstname','people.lastname')
	end

  # expect post-data:
  # params[:buy] => {:user_id => 1, :beverages => { 2 => 1, 3 => 4}}
  def buy
    beverages = buy_params[:buy][:beverages]
    user_id = buy_params[:buy][:user_id]

    tab = Tab.running.find_or_create_by(user_id: user_id)
    beverages.each do |id, count|
      beverage = Beverage.find(id)
      beverage_tab = tab.tabs.find_or_create_by(name: beverage.name, price: beverage.price, capacity: beverage.capacity)
      beverage_tab.count += count
    end
    tab.save
  end

	  private
    def set_tab
      @tab = Tab.find(params[:id])
    end

    def tab_params
      params.require(:tab).permit(:paid)
    end

    def has_permission
			redirect_to root_url, flash => {:error => 'You have no permission'} unless current_user.has_group?('kuehlschrank')
		end

    def correct_user
      redirect_to root_url, flash => {:error => 'You have no permission'} unless current_user.id == @tab.user_id
    end
end
