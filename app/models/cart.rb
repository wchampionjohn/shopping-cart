class Cart

  def initialize init_items = {}
    @storage = ::CartStorage.new # 抽離session
    @dao = ::CartDao.new # 抽離database

    init_items.each do |item|
      add_item(item.id, item.quantity)
    end
  end

  def set_dao dao
    @dao = dao
  end

  def set_storage storage
    @storage = storage
  end

  def add_item(product_id, quantity = 1)

    return false unless @dao.exists? product_id

    new_item = OpenStruct.new({id: product_id, quantity: quantity})

    item = @storage[product_id]

    @storage[product_id] = if item.nil?
                             new_item
                           else
                             item.quantity += new_item.quantity
                             item
                           end
  end

  def reduce_quantity(product_id, quantity = 1)
    item = @storage[product_id]
    item.quantity -= quantity
  end

  def items
    @storage.items
  end

  def empty?
    @storage.empty?
  end

  def total_price
    @dao.find_all(product_ids).reduce(0) do |total, product|
      quantity = @storage[product.id].quantity
      total += product.price * quantity
    end
  end

private
  def product_ids
    items.map(&:id)
  end

end
