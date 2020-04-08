class SessionsController < ApplicationController

  def new
    flash[:error] = "You are already logged in" if current_user.present?
    user_redirect
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
    redirect_to "/"
  end

  private

  def user_redirect
    redirect_to '/profile' if current_regular?
    redirect_to '/merchant' if current_merchant?
    redirect_to '/admin' if current_admin?
  end

end
