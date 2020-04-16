class Profile::OrdersController < Profile::BaseController

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    update_and_cancel(order) if cancelled?
  end

  private

  def update_params
    params.permit(:status)
  end

  def cancelled?
    params[:status] == "cancelled"
  end

  def cancel_item_order(order)
    order.item_orders.update_all(status: "unfulfilled")
    order.item_orders.each do |item_order|
      item_order.item.update(inventory: item_order.replace_inventory)
    end
  end

  def cancel_order_redirect
    flash[:notice] = "Your order (Order ID: #{params[:id]}) has been cancelled."
    redirect_to "/profile"
  end

  def update_and_cancel(order)
    order.update(update_params)
    cancel_item_order(order)
    cancel_order_redirect
  end

end
