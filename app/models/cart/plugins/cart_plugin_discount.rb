# 滿XX折扣XX(可以是扣掉金額或者折扣原價的百分比)
class CartPluginDiscount < CartPlugin
  def initialize cart
    @cart = cart
    @discount  = 0
  end


  def before_refresh_item item_key
    @discount  = 0
  end

  def after_refresh_item item_key
    total_price = @cart.get_total.origin

    if above_condition?
      @discount = case @type
                  when :cut
                    @offer
                  when :percent
                    (total_price * ((@offer / 100.0).round(2))).to_i
                  end
    end
  end

  def get_value
    @discount
  end

  def set_value(*args)
    @condition = args.first # 滿足條件
    @offer = args.second
    @type = args.last # :percent(原價的百分之@offer) or # :off(直接折扣掉@offer)
  end

  def above_condition?
    return false if @condition.nil?
    return false if @condition > @cart.get_total.origin

    true
  end

end

