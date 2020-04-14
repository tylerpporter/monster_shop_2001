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

  def update #this action will have to be hit when a merchant fulfills all items and that action will need a query param ?status="packaged"
    order = Order.find(params[:id])
    if cancelled?
      update_and_cancel(order)
      #the elsif has not been tested
    elsif fulfilled?(order)
      order.update(update_params)
    elsif params[:status] == "shipped"
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

  def cancelled?
    params[:status] == "cancelled"
  end

  def fulfilled?(order)
    order.item_orders.all? {|item_order| item_order.status == "fulfilled"}
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
