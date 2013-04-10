class TabsController < ApplicationController
	def index
	end

	def create
	end

	def show
	end

	def update
	end

	def new
		@tab.beverages << Beverage.available
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

end
