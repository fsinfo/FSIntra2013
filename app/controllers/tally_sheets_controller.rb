class TallySheetsController < ApplicationController
	before_action :signed_in_user, :has_permission , :get_users, :get_beverages 

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
		require 'thread'
		# "user" => {user_id => {beverage_id => {"count" => count, "price" => price}}}
		post = params[:user]
		mail_queue = Queue.new
		ActiveRecord::Base.transaction do
			@users.each do |user|
				beverages = post[user.id.to_s]
				tab = user.tabs.build(:paid => false)
				beverages.each do |id,array|
					unless array["count"].to_i == 0
						beverage = Beverage.find_cached(id)
						tab.beverage_tabs.build(:name => beverage.name, :price => beverage.price, :count => array["count"], :capacity => beverage.capacity) 
					end
				end
				if tab.save
					mail_queue << [user,tab]
				end
			end
		end
		Thread.new do
			while !mail_queue.empty?
				arr = mail_queue.pop
				TabMailer.tab_email(current_user,arr[0],arr[1])
			end
		end
		# TODO: better route
		redirect_to root_url
	end

	def edit_list
		@new_candidates = User.all.where(:on_beverage_list => false)
		@delete_candidates = User.all.where(:on_beverage_list => true)
	end

	def update_list
		User.where(:id => params['new']).update_all(:on_beverage_list => true)
		User.where(:id => params['delete']).update_all(:on_beverage_list => false)
		redirect_to strichliste_edit_url, notice: t('.successful')
	end

	private
		# TODO: get only the right users (active/on list)
		def get_users
			@users = User.all.where(:on_beverage_list => true).order('firstname, lastname')
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
