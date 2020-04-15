class Merchant::ItemOrdersController < Merchant::BaseController

  def update
   item_order = ItemOrder.find(params[:id])
   item_order.update(status: :fulfilled)
   item_order.order.package! if item_order.order.all_fulfilled?
   flash[:notice] = "#{item_order.item.name} has been fulfilled"
   redirect_to "/merchant/orders/#{item_order.order_id}"
  end
  
end
