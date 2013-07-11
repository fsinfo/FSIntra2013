class UsersController < PeopleController
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
    def user_params
      params.require(:user).permit(:firstname, :lastname, :street, :zip, :city, :email, :phone, :birthday, :misc, :tag_list)
    end
end
