class Item <ApplicationRecord
  after_initialize :set_defaults
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0

  def set_defaults
    default_image = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.123rf.com%2Fstock-photo%2Fno_image_available.html&psig=AOvVaw30kiGxMy2gbAtnTgpSwWu0&ust=1586966141754000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKiq-9qj6OgCFQAAAAAdAAAAABAD"
    self.image = default_image if self.image == ""
  end

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def total_quantity_ordered
    item_orders.sum(:quantity)
  end

  def self.all_active
    where(active?: true)
  end

  def self.five_most_popular
    joins(:item_orders).group("items.id").order("SUM(item_orders.quantity) DESC").take(5)
  end

  def self.five_least_popular
    joins(:item_orders).group("items.id").order("SUM(item_orders.quantity)").take(5)
  end

end
