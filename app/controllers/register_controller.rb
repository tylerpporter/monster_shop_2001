class RegisterController < ApplicationController
  def new
    @user_info = {}
  end

  def create
    user = User.create(user_params)
    if user.save
      flash[:notice] = "Welcome #{params[:name]} Registration Successful"
      session[:user_id] = user.id
      redirect_to "/profile"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      @user_info = user_params
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
