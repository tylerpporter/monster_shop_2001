class OrdersController <ApplicationController

  def new
  end

  def create
    order = current_user.orders.create(order_params)
    order.save ? success(order) : failure
  end

  def update
    order = Order.find(params[:id])
    if params[:status] == "shipped"
      order.update(update_params)
      redirect_to admin_path
    end
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
