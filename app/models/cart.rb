class Cart

  def initialize
    @storage = CartStorage.new # 抽離session
    @dao = CartDao.new # 抽離database
  end


  def set_dao(dao)
    @dao = dao
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

  def items
    @storage.items
  end

  def empty?
    @storage.empty?
  end

end
