class SessionsController < ApplicationController
	def new
	end

	def create
		if User.authenticate(params[:loginname],params[:password])
			user = User.find_by_loginname(params[:loginname])
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
