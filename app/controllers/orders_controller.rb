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

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def create_item_orders(order)
    cart.items.each do |item,quantity|
      order.item_orders.create({
        item: item,
        quantity: quantity,
        price: item.price
        })
      end
  end

  def successful_redirect
    session.delete(:cart)
    flash[:notice] = "Your order has been created"
    redirect_to "/profile/orders"
  end

  def success(order)
    create_item_orders(order)
    successful_redirect
  end

  def failure
    flash[:notice] = "Please complete address form to create an order."
    render :new
  end

end
