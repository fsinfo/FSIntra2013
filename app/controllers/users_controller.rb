class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  before_action :signed_in_user
  before_action :correct_user, only: [:update]

  def update
    if @user.update(user_params)
			login @user
      redirect_to person_path(@user), notice: t('.successful')
    else
      render action: 'edit'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname, :lastname, :street, :zip, :city, :email, :phone, :birthday, :misc)
    end

		def correct_user
			redirect_to(root_path) unless current_user?(@user)
		end
end
