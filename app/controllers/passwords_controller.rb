class PasswordsController < ApplicationController
  def edit
  end

  def update
    user = User.find_by(email: params[:email])
    user.update(user_params)
    if user.save
      flash[:success] = "Your password is updated"
      redirect_to "/profile"
    else
      flash[:error] = "Please enter valid & matching passwords"
      render :update
    end
  end

  private

  def user_params
    params.require(:current_user).permit(:password, :password_confirmation)
  end
end
