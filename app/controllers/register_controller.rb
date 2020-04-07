class RegisterController < ApplicationController
  def new
    @user_info = {}
  end

  def create
    user = User.create(user_params)
    user.save ? success(user) : failure(user)
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def success(user)
    flash[:notice] = "Welcome #{params[:name]} Registration Successful"
    session[:user_id] = user.id
    redirect_to "/profile"
  end

  def failure(user)
    flash[:error] = user.errors.full_messages.to_sentence
    @user_info = user_params
    render :new
  end

end
