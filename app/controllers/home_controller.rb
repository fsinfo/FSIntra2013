class HomeController < ApplicationController
	before_action :signed_in_user
	
	def index
		@unpaid_tabs = current_user.tabs.unpaid
	end
end
