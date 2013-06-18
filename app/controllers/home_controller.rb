class HomeController < ApplicationController
	before_action :signed_in_user
	
	def index
    @running_tab = current_user.tabs.running
		@unpaid_tabs = current_user.tabs.unpaid
    @birthday_people = User.all.sort_by(&:days_to_next_birthday).first(5)
	end
end
