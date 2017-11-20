class Cart

  def initialize
    @storage = CartStorage.new
  end

  def add_item(product_id, quantity = 1)
    new_item = OpenStruct.new({id: product_id, quantity: quantity})

    item = @storage[product_id]

    @storage[product_id] = if item.nil?
                             new_item
                           else
                             item.quantity += new_item.quantity
                             item
                           end
  end

  def items
    @storage.items
  end

  def empty?
    @storage.empty?
  end
end
