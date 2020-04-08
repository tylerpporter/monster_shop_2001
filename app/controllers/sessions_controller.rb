class SessionsController < ApplicationController
  def new
     if current_user.present?
      flash[:error] = "You are already logged in"
      if current_user.regular?
        redirect_to "/profile"
      elsif current_user.admin?
        redirect_to "/admin"
      elsif current_user.merchant?
        redirect_to "/merchant"
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are logged in"

      if user.regular?
        redirect_to "/profile"
      elsif user.admin?
        redirect_to "/admin"
      elsif user.merchant?
        redirect_to "/merchant"
      end
    else
      flash[:danger] = "Email and/or Password is incorrect"
      redirect_to "/login"
    end
  end

  def destroy
    session.delete(:cart)
    session[:user_id] = nil
    flash[:notice] = "You are logged out"
    redirect_to "/login"
  end
end
