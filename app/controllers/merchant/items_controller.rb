class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = current_user.merchant
  end

  def update
    item = Item.find(params[:id])
    item.update(update_params)
    flash[:notice] = "#{item.name} is no longer for sale"
    redirect_to '/merchant/items'
  end

  private

  def update_params
    params.permit(:active?)
  end

end
