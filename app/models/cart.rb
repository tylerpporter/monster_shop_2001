class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
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

  def max_quantity?(item_id)
    Item.find(item_id).inventory <= @contents[item_id]
  end

  def decrement(item_id)
    @contents[item_id] -= 1
  end

  def remove(item_id)
    @contents.delete(item_id)
  end

  def quantity_zero?(item_id)
    @contents[item_id] <= 0
  end

end
