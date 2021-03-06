class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  enum status: { pending: 0, packaged: 1, shipped: 2, cancelled: 3 }

  def self.gather(status)
    Order.where(status: status)
  end

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
    all_items_for(merchant).sum(:quantity)
  end

  def all_items_for(merchant)
    merchant.item_orders.where(order_id: self.id)
  end

  def total_value_for(merchant)
    x = merchant.item_orders.where(order_id: self.id)
    x.sum('item_orders.price * item_orders.quantity').to_i
  end

  def total_item_quantity
    item_orders.sum(:quantity)
  end

  def all_fulfilled?
    # item_orders.where(status: "unfulfilled").empty? benchmark = 7.507805 10,000 pulls
    item_orders.all? {|item_order| item_order.status == "fulfilled"} #benchmark = .034 10,000 pulls
  end

  def package!
    self.update(status: "packaged")
  end

end
