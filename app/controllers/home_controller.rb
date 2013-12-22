class HomeController < ApplicationController
	before_action :signed_in_user
	
	def index
		@running_tab = current_user.tabs.running.includes(:beverage_tabs).first
		@unpaid_tabs = current_user.tabs.unpaid.includes(:beverage_tabs) 
		@birthday_people = Person.all.sort_by(&:days_to_next_birthday).first(5)
	end
end
