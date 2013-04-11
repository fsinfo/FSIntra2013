class TabsController < ApplicationController
	before_action :set_tab, only: [:update, :new, :show]
	before_action :has_permission, only: [:update, :unpaid]

	def index
		@unpaid_tabs = current_user.tabs.unpaid
		@paid_tabs = current_user.tabs.paid
	end

	def show
		@beverage_tabs = @tab.beverage_tabs
	end

	def update
		@tab.is_paid
		@tab.save
	end

	def unpaid
		@tabs = Tab.unpaid
	end

	  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tab
      @tab = Tab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tab_params 
      params.require(:tab)
    end

    def has_permission
			has_group('kuehlschrank')
		end

end
