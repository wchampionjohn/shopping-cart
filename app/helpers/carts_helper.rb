module CartsHelper
  def current_cart
    if @cart
      @cart
    else
      CartPluginTotal
      cart = Cart.new
      cart.set_dao CartDaoProduct.new # 從db找product
      cart.register_plugin('total')
      cart.register_plugin('discount')
      cart.register_plugin('costs')

      function = CartFunction.find_by_name('discount')
      if function.setting.is_opening?
        setting = function.setting
        discount = if setting.percent?
                     setting.percent_off
                   elsif setting.cut?
                     setting.offer
                   end
        cart.set_discount(setting.condition, discount, setting.discount_type.to_sym)
      end

      function = CartFunction.find_by_name('costs')
      if function.is_open
        CostRule.opening_rules.each do |rule|
          cart.set_costs(rule.cost, rule.reach)
        end
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
