module CartsHelper
  def current_cart
    if @cart
      @cart
    else
      cart = Cart.new
      cart.set_dao CartDaoProduct.new # 從db找product
      cart.register_plugin('total')

      CartFunction.all.each do |function|
        function.stuff cart if function.is_open
      end

      current_items.each do |item|
        cart.add_item(item['id'], item['quantity'])
      end

      @cart = cart
    end
  end

  def current_items
    session['cart'] || {}
  end
end
