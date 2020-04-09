class PasswordsController < ApplicationController
  def edit
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:success] = "Your Password Has Been Updated"
      redirect_to "/profile"
    else
      flash[:error] = "Please enter valid & matching passwords"
      redirect_to "/password/edit"
    end
  end

  private

  def user_params
    params.permit(:password, :password_confirmation)
  end
end
