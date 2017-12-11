module CartsHelper
  def current_cart
    if @cart
      @cart
    else
      CartPluginTotal
      cart = Cart.new current_items
      cart.set_dao CartDaoProduct.new # 從db找product
      cart.register_plugin('total')
      @cart = cart
    end
  end

  def current_items
    session['cart'] || {}
  end
end
