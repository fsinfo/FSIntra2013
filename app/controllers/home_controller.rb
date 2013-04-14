class HomeController < ApplicationController
	def index
		@unpaid_tabs = current_user.tabs.unpaid
	end
end
