class UsersController < PeopleController
  before_action :set_user, only: [:update, :edit]
  before_action :signed_in_user
  before_action :correct_user, only: [:update, :edit]

  def update
    if @user.update(user_params)
			login @user
      redirect_to @user, notice: t('feedback.updated', :model => User.model_name.human)
    else
      @person = @user
      render 'edit'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname, :lastname, :street, :zip, :city, :email, :phone, :birthday, :misc, :tag_list)
    end

		def correct_user
			redirect_to(root_path) unless current_user?(@user)
		end
end
