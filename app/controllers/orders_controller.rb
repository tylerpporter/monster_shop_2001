class OrdersController <ApplicationController

  def new
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create(order_params)
    order.save ? success(order) : failure
  end

  def update
    order = Order.find(params[:id])
    order.update(update_params)
    order.item_orders.each do |item_order|
      item_order.update(status: "unfulfilled")
      item_order.item.update(inventory: item_order.item.inventory += item_order.quantity)
    end
    flash[:notice] = "Your order (Order ID: #{params[:id]}) has been cancelled."
    redirect_to "/profile"
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def update_params
    params.permit(:status)
  end

  def successful_redirect
    session.delete(:cart)
    flash[:notice] = "Your order has been created"
    redirect_to "/profile/orders"
  end

  def success(order)
    order.create_item_orders(cart.items)
    successful_redirect
  end

  def failure
    flash[:notice] = "Please complete address form to create an order."
    render :new
  end

end
