class CartPluginTotal < CartPlugin

  def initialize cart
    @cart = cart
    @total = 0
  end

  def before_add_item item_key
    @total = 0
  end

  def after_add_item item_key

    @total = @cart.items.reduce(0) do |result, item|
      result += calculate(item.product.price, item.product.id)  * item.quantity
      result
    end
  end

  def calculate(price, id)
    if @cart.plugin_exists? 'special'
      special_offer_table = @cart.get_special
      special_offer_table.keys.include?(id) ? special_offer_table[id][:price] : price
    else
      price
    end
  end

  def get_value
    @total
  end

  def set_value total
    @total = total
  end

end
