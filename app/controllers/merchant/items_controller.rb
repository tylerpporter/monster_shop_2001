class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = current_user.merchant
  end

  def new
    @merchant = current_user.merchant
  end

  def create
    merchant = current_user.merchant
    item = merchant.items.create(item_params)
    flash_and_redirect(item)
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

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end

  def update_params
    params.permit(:active?)
  end

  def flash_and_redirect(item)
    flash[:notice] = "#{item.name} is no longer for sale" if !item.active? && params[:action] == "update"
    flash[:notice] = "#{item.name} is now available for sale" if item.active? && params[:action] == "update"
    flash[:notice] = "#{item.name} has been deleted" if params[:action] == "destroy"
    flash[:notice] = "#{item.name} has been saved" if params[:action] == "create"
    redirect_to '/merchant/items'
  end

end
