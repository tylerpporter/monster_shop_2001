class RegisterController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save ? success(@user) : failure(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def success(user)
    flash[:notice] = "Welcome #{params[:user][:name]} Registration Successful"
    session[:user_id] = user.id
    redirect_to "/profile"
  end

  def failure(user)
    flash[:error] = user.errors.full_messages.to_sentence
    render action: :new
  end

end
