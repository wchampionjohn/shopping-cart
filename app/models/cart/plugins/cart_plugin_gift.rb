# 買A送B
class CartPluginGift < CartPlugin

  def initialize cart
    @cart = cart
    @gift_table = {} # 購買和贈送的對應
    @current_gifts = {} # 目前購買清單有贈送哪些商品
  end

  def after_add_item id
    id = id.to_s
    if @gift_table.keys.include? id
      set_gifts id
    end
  end

  alias after_update_item after_add_item

  def after_remove_item id
    @current_gifts.delete id
  end

  def get_value
    @current_gifts
  end

  def set_value(*args)
    id = args.first.to_s
    @gift_table[id] ||= []
    @gift_table[id] << args.last
  end

  private
  def set_gifts id
    item = @cart.items.find { |item| item.id == id }
    @current_gifts[id] = @gift_table[id]
  end
end
