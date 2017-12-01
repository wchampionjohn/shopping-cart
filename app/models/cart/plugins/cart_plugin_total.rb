class CartPluginTotal < CartPlugin

  def get_value
    total = @cart.items.reduce(0) do |result, item|
      price = if special? item.id
                special_price item.id
              else
                item.product.price
              end

      if additional? item.id
        addition = @cart.get_additional[item.id]
        result += addition[:amount] * addition[:price] + (item.quantity - addition[:amount]) * price
      else
        result += price * item.quantity
      end

      result
    end

    total_special_offer = if @cart.plugin_exists? 'discount'
                            total - @cart.get_discount
                          else
                            total
                          end
    OpenStruct.new(
      {
        origin: total,
        special: total_special_offer
      }
    )
  end

private
  # 是否特價品
  def special?(id)
    @cart.plugin_exists?('special') && @cart.get_special.keys.include?(id)
  end

  def special_price id
    special_offer_table = @cart.get_special
    special_offer_table[id][:price]
  end

  # 是否加購品
  def additional? id
    @cart.plugin_exists?('additional') && @cart.get_additional[id].present?
  end

end
