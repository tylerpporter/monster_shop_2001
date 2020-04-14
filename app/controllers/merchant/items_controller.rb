class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = current_user.merchant
  end

  def update
    item = Item.find(params[:id])
    item.update(update_params)
    flash_and_redirect(item)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash_and_redirect(item)
  end

  private

  def update_params
    params.permit(:active?)
  end

  def flash_and_redirect(item)
    flash[:notice] = "#{item.name} is no longer for sale" if !item.active? && params[:action] == "update"
    flash[:notice] = "#{item.name} is now available for sale" if item.active? && params[:action] == "update"
    flash[:notice] = "#{item.name} has been deleted" if params[:action] == "destroy"
    redirect_to '/merchant/items'
  end

end
