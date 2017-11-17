class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(product_id, quantity = 1)
    if items.all? { |item| item.id != product_id }
      items << OpenStruct.new({id: product_id, quantity: quantity})
    else
      items.map! do |item|
        item.id == product_id
          ? OpenStruct.new({id: item.id, quantity: item.quantity + 1})
          : item
      end
    end
  end

  def empty?
    items.empty?
  end
end
