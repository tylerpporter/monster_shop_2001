class Merchant::ItemOrdersController < Merchant::BaseController

  def update
   item_order = ItemOrder.find(params[:id])
   item_order.update(status: :fulfilled)
   update_order(item_order)
   flash_and_redirect(item_order)
  end

  private

  def update_order(item_order)
    item_order.order.package! if item_order.order.all_fulfilled?
  end

  def flash_and_redirect(item_order)
    flash[:notice] = "#{item_order.item.name} has been fulfilled"
    redirect_to "/merchant/orders/#{item_order.order_id}"
  end 

end
