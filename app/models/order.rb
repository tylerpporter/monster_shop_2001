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

  def total_item_quantity
    item_orders.sum(:quantity)
  end


end
