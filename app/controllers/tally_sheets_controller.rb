class TallySheetsController < ApplicationController
	before_action :get_users, :get_beverages, :has_permission
	def index
	end

	def new
	end

	def create
		# "user" => {user_id => {beverage_id => {"count" => count, "price" => price}}}
		post = params[:user]
		@users.each do |user|
			temp = post[user.id.to_s]
			tab = user.tabs.build(:paid => false)
			temp.each do |id,array|
				unless array["count"].to_i == 0
					tab.beverage_tabs.build(:beverage_id => id, :count => array["count"], :price => array["price"]) 
				end
			end
			tab.save if tab.total_invoice > 0
		end
		# TODO: better route, send mails
		redirect_to root_url
	end

	private
		# TODO: get only the right users (active/on list)
		def get_users
			@users = User.all
		end

		def get_beverages
			@beverages = Beverage.available
		end

		def has_permission
			unless has_group('kuehlschrank')
				redirect_to root_url, flash => {:error => 'You have no permission'}
			end
		end
end
