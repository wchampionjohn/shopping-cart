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
      result += item.product.price * item.quantity
      result
    end
  end

  def get_value
    @total
  end

end
