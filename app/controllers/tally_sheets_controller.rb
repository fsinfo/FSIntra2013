class TallySheetsController < ApplicationController
	before_action :get_users, :get_beverages
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
				tab.beverage_tabs.build(:beverage_id => id, :count => array["count"], :price => array["price"])
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
end
