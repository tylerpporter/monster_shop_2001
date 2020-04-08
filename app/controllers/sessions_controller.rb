class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are logged in"

      if user.basic?
        redirect_to "/profile"
      elsif user.admin?
        redirect_to "/admin"
      elsif user.merchant?
        redirect_to "/merchant"
      end
    else
      flash[:error] = "Email and/or Password is incorrect"
      redirect_to "/login"
    end
  end
end
