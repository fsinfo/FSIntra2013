class TallySheetsController < ApplicationController
	before_action :get_users, :get_beverages, :has_permission
	def index
	end

	def new
		respond_to do |format|
			format.html
			format.pdf do 
				pdf = TallySheetPdf.new(@users, @beverages)
				send_data pdf.render, filename: "tally_sheet.pdf", type: "application/pdf", disposition: "inline"
			end
		end
	end

	def create
		# "user" => {user_id => {beverage_id => {"count" => count, "price" => price}}}
		post = params[:user]
		@users.each do |user|
			temp = post[user.id.to_s]
			tab = user.tabs.build(:paid => false)
			puts temp
			temp.each do |id,array|
				unless array["count"].to_i == 0
					beverage = Beverage.find(id)
					tab.beverage_tabs.build(:name => beverage.name, :price => beverage.price, :count => array["count"], :capacity => beverage.capacity) 
				end
			end
			if tab.total_invoice > 0 and tab.save
				TabMailer.tab_email(current_user,user,tab)
			end
		end
		# TODO: better route
		redirect_to root_url
	end

	private
		# TODO: get only the right users (active/on list)
		def get_users
			@users = User.all.order('firstname, lastname')
		end

		def get_beverages
			@beverages = Beverage.available
		end

		def has_permission
			unless has_group?('kuehlschrank')
				redirect_to root_url, flash => {:error => 'You have no permission'}
			end
		end
	end
