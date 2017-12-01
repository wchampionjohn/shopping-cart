# 指定商品特價
class CartPluginSpecial < CartPlugin

  def initialize cart
    @cart = cart
    @settings = []
    @offer_table = {}
  end

  def after_add_item item_key
    ids = @settings.map { |setting| setting[:id] }

    if ids.include? item_key
      setting = find_setting item_key
      product = find_product item_key

      price = case setting[:type]
              when :cut
                product.price - setting[:discount]
              when :percent
                product.price - (product.price * ((setting[:discount] / 100.0).round(2))).to_i
              when :offer
                setting[:discount]
              end

      @offer_table[item_key] = { price: price }
    end
  end

  def after_remove_item item_key
    @offer_table.delete(item_key)
  end

  def get_value
    @offer_table
  end

  def set_value(*args)
    @settings.push({
      id: args.first,
      discount: args.second,
      type: args.last
    })
  end

private
  def find_setting id
    @settings.find { |setting| setting[:id] == id }
  end

  def find_product id
    @cart.items.map(&:product).find { |product| product.id == id}
  end
end
