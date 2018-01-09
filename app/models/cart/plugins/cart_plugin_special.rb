# 指定商品特價
class CartPluginSpecial < CartPlugin

  def initialize cart
    @cart = cart
    @settings = []
    @offer_table = {}
  end

  def after_add_item id
    ids = @settings.map { |setting| setting[:id] }

    if ids.include? id
      setting = find_setting id
      product = find_product id

      price = case setting[:type]
              when :cut
                product.price - setting[:discount]
              when :percent
                product.price - (product.price * ((setting[:discount] / 100.0).round(2))).to_i
              when :specific
                setting[:discount]
              end

      @offer_table[id] = { price: price }
    end
  end

  def after_remove_item id
    @offer_table.delete(id)
  end

  def get_value
    @offer_table
  end

  def set_value(*args)
    @settings.push({
      id: args.first.to_s,
      discount: args.second,
      type: args.last
    })
  end

private
  def find_setting id
    @settings.find { |setting| setting[:id] == id }
  end

  def find_product id
    @cart.items.map(&:product).find { |product| product.id.to_s == id}
  end
end
