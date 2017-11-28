# 滿XX折扣XX(可以是扣掉金額或者折扣原價的百分比)
class CartPluginDiscount < CartPlugin

  def after_add_item item_key
    total_price = @cart.get_total

    if above_condition?
      discount = case @type
                 when :cut
                   @discount
                 when :percent
                   (total_price * ((@discount / 100.0).round(2))).to_i
                 end

      @cart.set_total(total_price - discount)
    end
  end

  def set_value(*args)
    @condition = args.first # 滿足條件
    @discount = args.second
    @type = args.last # :percent(原價的百分之@discount) or # :off(直接折扣掉@discount)
  end

  def above_condition?
    return false if @condition.nil?
    return false if @condition > @cart.get_total

    true
  end

end
