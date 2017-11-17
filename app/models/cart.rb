class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end


  def add_item(product_id, quantity = 1)
    items << { id: product_id, quantity: quantity }
  end

  def empty?
    items.empty?
  end
end
