class TabsController < ApplicationController
	before_action :set_tab, only: [:update, :new, :show, :edit, :pay]
	before_action :signed_in_user
	before_action :has_permission, only: [:update, :unpaid, :pay, :edit]

	def index
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
		@tab.is_paid
		@user = @tab.user
		TabMailer.paid_email(current_user, @user, @tab) if @tab.save
		render :nothing => true
	end

	def unpaid
		@tabs = Tab.unpaid.joins(:user).includes(:beverage_tabs).order('people.firstname','people.lastname')
	end

	  private
    def set_tab
      @tab = Tab.find(params[:id])
    end

    def tab_params
      params.require(:tab).permit(:paid)
      # params.require(:tab).permit!
    end

    def has_permission
			redirect_to root_url, flash => {:error => 'You have no permission'} unless current_user.has_group?('kuehlschrank')
		end

end
