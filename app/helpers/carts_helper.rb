module CartsHelper
  def current_cart
    return @cart if @cart

    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product
    cart.register_plugin('total')

    # 設定其他功能
    CartFunction.all.each do |function|
      function.stuff cart if function.is_open
    end

    current_items.each do |item|
      cart.add_item(item['id'], item['quantity'])
    end

    @cart = cart
  end

  def current_items
    session['cart'] || {}
  end
end
