class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :merchant_employees
  has_many :users, through: :merchant_employees

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :enabled?
  validates_inclusion_of :enabled?, in:([true, false])

  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def hire(user)
    merchant_employees.create(user: user)
    user.update(role: 1)
  end

  def pending_orders
    order_ids = item_orders.pluck(:order_id).uniq
    Order.where(id: order_ids)
  end
end
