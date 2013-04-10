class SessionsController < ApplicationController
	def new
	end

	def create
		user, groups = User.authenticate(params[:loginname],params[:password])
		unless user.nil?
			login user
			flash[:success] = "Hello #{user.firstname}!"
			redirect_back_or root_url
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		logout
		redirect_to root_url
	end
end
