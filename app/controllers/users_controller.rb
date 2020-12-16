class UsersController < ApplicationController
  def edit_manager_profile
    if !current_user.manager
      redirect_to root_path
      flash[:alert] = "Oops, something went wrong"
    end
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated!"
      redirect_to profiles_path
    else
      flash[:notice] = "Oops, something went wrong. Please try again!"
      redirect_to 'edit'
    end
  end


  def user_params
    params.require(:user).permit(:whatsapp_number, :title, :company, :photo)
  end
end
