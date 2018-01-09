class CartDaoProduct < CartDao

  def exists? id
    Product.exists? id
  end

  def find key
    key = key.split('-')
    product_id = key[0]
    product = Product.find product_id

    if key.size > 1
      spec = Spec.find key[1]
      product.title = "#{product.title} (#{spec.name}) "
      product.remain = spec.quantity
    end

    product
  end

  def find_all keys
    keys.map{ |key| find(key) }

  end

end
