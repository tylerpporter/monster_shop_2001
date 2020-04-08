class SessionController < ApplicationController

  def new
    flash[:error] = "You are already logged in" if current_user.present?
    user_redirect
  end

  def create
    user = User.find_by(email: params[:email])
    authenticate(user) ? login(user) : invalid_user
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

  def login(user)
    session[:user_id] = user.id
    flash[:notice] = "You are logged in"
    user_redirect
  end

  def authenticate(user)
    user.present? && user.authenticate(params[:password])
  end

  def invalid_user
    flash[:error] = "Email and/or Password is incorrect"
    redirect_to "/login"
  end

end
