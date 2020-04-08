class ProfileController < ApplicationController
  def show
    render file: "/public/404" if current_user.nil?
    @user = current_user
  end
end
