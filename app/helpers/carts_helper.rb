module CartsHelper
  def current_cart
    return @cart if @cart

    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product

    available_functions = CartFunction.select { |function| function.is_open }
    available_plugins_name = available_functions.map(&:name)
    available_plugins_name << 'total'

    order = {
      'special' => 1,
      'total'   => 2,
      'discount' => 3,
      'costs' => 4,
      'additional' => 4,
      'gift' => 5
    }

    available_plugins_name = available_plugins_name.sort { |name1, name2| order[name1] <=> order[name2] }
    available_plugins_name.each { |plugin| cart.register_plugin plugin }

    # 設定其他功能
    CartFunction.all.each do |function| { }
      function.stuff cart if function.is_open
    end

    current_items.each do |item|
      cart.add_item(item['key'], item['quantity'])
    end

    @cart = cart
  end

  def current_items
    session['cart'] || []
  end

  def memo(cart, current_item)
    if cart.plugin_exists?('additional') && cart.get_additional.keys.include?(current_item.id)
      index = cart.items.find_index{ |item| item.id == cart.get_additional[current_item.id][:purchase] }
      "商品##{index + 1} 加購價#{currency(cart.get_additional[current_item.id][:price])}"
    end
  end

  # 重新某商品贈品小計
  def calculate_amount(cart, item)
    if cart.plugin_exists?('additional') && cart.get_additional.keys.include?(item.id)
      # 購買數量大於加購價數量
      if item.quantity > cart.get_additional[item.id][:amount]
        origin_price = (item.quantity - cart.get_additional[item.product.id.to_s][:amount]) * item.product.real_price
        additional_price = cart.get_additional[item.id][:price] * cart.get_additional[item.id][:amount]

        origin_price + additional_price
      else
        item.quantity * cart.get_additional[item.id][:price]
      end
    else
      item.product.real_price * item.quantity
    end

  end

  # 重新計算所有加購品小計
  def recalculate_additions(cart, current_item)
    if is_purchase?(cart, current_item.id)
      ids = cart.get_additional.reduce([]) do |result, (id, addition)|
        result << id if addition[:purchase] == current_item.id
        result
      end

      ids.reduce({}) do | result, id|
        item = cart.items.find { |item| item.id == id}
        result[id] = currency(calculate_amount(cart, item))
        result
      end
    end
  end

  def is_purchase?(cart, item_id)
    ids = cart.get_additional.values.map { |addition| addition[:purchase] }
    ids.include? item_id
  end


end
