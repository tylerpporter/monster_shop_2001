class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def create_item_orders(cart_items)
    cart_items.each do |item,quantity|
      self.item_orders.create({
      item: item,
      quantity: quantity,
      price: item.price
      })
    end
  end

 def total_items_for(merchant)
    x = merchant.item_orders.where(order_id: self.id).sum(:quantity)
 end

 def total_value_for(merchant)
  x = merchant.item_orders.where(order_id: self.id)
  x.sum { |io| io.price * io.quantity }.to_i
 end
end
