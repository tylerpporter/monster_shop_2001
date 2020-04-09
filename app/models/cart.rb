class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
    @contents.default = 0
  end

  def add_item(item)
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    @contents.reduce({}) do |items, (item_id, quantity)|
      items[Item.find(item_id)] = quantity
      items
    end
  end

  def subtotal(item)
    item.price * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id,quantity|
      Item.find(item_id).price * quantity
    end
  end

end
