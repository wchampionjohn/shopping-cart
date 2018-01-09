# 買A加價購B
class CartPluginAdditional < CartPlugin

  def initialize cart
    @cart = cart
    @additions_table = {}
    @current_additions = {}
  end

  def after_add_item id
    # 加入的商品如果是A或B名單內
    if addition_ids.include?(id) || purchase_ids.include?(id)
      set_additions id # 設定加購價表，如果符合加價購條件
    end
  end

  alias after_update_item after_add_item

  def after_remove_item id
    if addition_ids.include? id # 移除的商品是B
      addition_id = id
      @current_additions.delete(addition_id)
    elsif purchase_ids.include? id # 移除的商品是A
      additions = @additions_table[id]
      additions.each { |addition| @current_additions.delete(addition[:addition])}
    end
  end

  def get_value
    @current_additions
  end


  # 一個A可以同時設定多個B，所以格式會如下
  # @additions_table[A] =
  # [
  #   { addition: B, price: 加購價 },
  #   { addition: B, price: 加購價 },
  # ]
  #
  def set_value(*args)
    id = args.first.to_s.split('-')[0]
    additions = @additions_table[id] || []
    additions << { addition: args.second.to_s, price: args.last }
    @additions_table[id] = additions
  end

private
  def addition_ids
    @additions_table.values.flatten.map { |table| table[:addition] }
  end

  def purchase_ids
    @additions_table.keys
  end

  def set_additions id
    items = @cart.items

    if addition_ids.include? id # 加入的商品是B
      # 找到對應的A
      addition = @additions_table.select do |purchase_id, ads|
        ads_id = ads.map { |ad| ad[:addition] }
        ads_id.include? id
      end
      purchase_id = addition.keys.first

     addition_ids_of_purchase = [id]
    elsif purchase_ids.include? id # 加入的商品是A
      # 找到對應的所有B
      addition_ids_of_purchase = @additions_table[id].map { |addition| addition[:addition] }
      purchase_id = id
    end

    # 購物車裡的A
    purchase_item = items.find { |item| item.id == purchase_id }
    # 購物車裡的所有B
    addition_items = items.select { |item| addition_ids_of_purchase.include? item.id }

    if purchase_item.present? && addition_items.present? # A跟B同時存在，設定加購價表
      addition_items.each do |item|
        # 找到加購設定
        addition = @additions_table[purchase_id].find { |addition| addition[:addition] == item.id }
        quantity = items.reduce(0) do |result, item|
          result += item.quantity if item.id == purchase_id
          result
        end
        # 設定加購表
        @current_additions[addition[:addition]] = {
          purchase: purchase_id,
          amount: quantity, # 買B有加購價的商品數量
          price: addition[:price]
        }
      end
    end
  end
end
