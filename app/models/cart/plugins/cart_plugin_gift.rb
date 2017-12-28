# 買A送B
class CartPluginGift < CartPlugin

  def initialize cart
    @cart = cart
    @gift_table = {} # 購買和贈送的對應
    @current_gifts = {} # 目前購買清單有贈送哪些商品
  end

  def after_add_item item_key
    item_key = item_key.to_s
    if @gift_table.keys.include? item_key
      set_gifts item_key
    end
  end

  alias after_update_item after_add_item

  def after_remove_item item_key
    @current_gifts.delete item_key
  end

  def get_value
    @current_gifts
  end

  def set_value(*args)
    item_key = args.first.to_s
    @gift_table[item_key] ||= []
    @gift_table[item_key] << args.last
  end

  private
  def set_gifts item_key
    item = @cart.items.find { |item| item.id == item_key }
    @current_gifts[item_key] = @gift_table[item_key]
  end
end
