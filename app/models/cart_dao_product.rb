class CartDaoProduct < CartDao

  def exists? id
    Product.exists? id
  end

  def find id
    Product.find_by id
  end

  def find_all ids
    Product.where(id: ids).all
  end

end