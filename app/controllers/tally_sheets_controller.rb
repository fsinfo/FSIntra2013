class TallySheetsController < ApplicationController
	before_action :get_users, :get_beverages
	def index
	end

	def new
		@users.each do |user|
			user.tabs << Tab.new
		end
	end

	def create
	end

	private
		# TODO: get only the right users
		def get_users
			@users = User.all
		end

		def get_beverages
			@beverages = Beverage.all.where(:available => true)
		end
end
