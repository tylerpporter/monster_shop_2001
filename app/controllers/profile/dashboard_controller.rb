class Profile::DashboardController < Profile::BaseController

  def show
    render file: "/public/404" if current_user.nil?
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params.to_h)

    if @user.save
      flash[:notice] = "Your profile has been updated"
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
  
end
