class PasswordsController < ApplicationController

  def edit
  end

  def update
    @user = current_user
    @user.update(password_params)
    if @user.save
      flash[:success] = "Your Password Has Been Updated"
      redirect_to "/profile"
    else
      flash[:error] = "Please enter valid & matching passwords"
      render :edit
    end
  end

  private

  def password_params
    params.permit(:password, :password_confirmation)
  end

end
