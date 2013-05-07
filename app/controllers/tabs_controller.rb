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
		@tabs = Tab.unpaid.includes(:beverage_tabs, :user)
	end

	  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tab_params 
      # params.require(:tab).permit(beverage_tabs_attributes: :count)
      params.require(:tab).permit!
    end

    def has_permission
			unless has_group?('kuehlschrank')
				redirect_to root_url, flash => {:error => 'You have no permission'}
			end
		end

end
