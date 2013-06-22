class HomeController < ApplicationController
	before_action :signed_in_user
	
	def index
    @running_tab = current_user.tabs.running.first
		@unpaid_tabs = current_user.tabs.unpaid 
    @birthday_people = Person.all.sort_by(&:time_to_next_birthday).first(5)
	end
end
