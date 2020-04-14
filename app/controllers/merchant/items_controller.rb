class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = current_user.merchant
  end

  def update
    item = Item.find(params[:id])
    item.update(update_params)
    flash_notice(item)
    redirect_to '/merchant/items'
  end

  private

  def update_params
    params.permit(:active?)
  end

  def flash_notice(item)
    flash[:notice] = "#{item.name} is no longer for sale" if !item.active?
    flash[:notice] = "#{item.name} is now available for sale" if item.active?
  end

end
