class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(params[:item_id])
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def show
    render file:"/public/404" if current_admin?
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def add_or_sub
    params[:add?] ? increment(params[:item_id]) : decrement(params[:item_id])
    redirect_to cart_path
  end

  private

  def increment(item)
    cart.add_item(item) unless cart.max_quantity?(item)
  end

  def decrement(item)
    cart.decrement(item)
    cart.remove(item) if cart.quantity_zero?(item)
  end
end
